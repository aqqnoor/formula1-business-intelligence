/*
==========================================================
Файл: sql/analytics/01_stage_performance.sql

Бизнес-вопрос:
* Какие Гран-при являются наиболее успешными?


Бизнес-интерпретация:
Обгоном считается ситуация, когда гонщик финиширует выше своей стартовой позиции.

KPI:
Общее количество обгонов за гонку

Формула:
SUM(grid - positionOrder)

Таблицы:
results
races

Ожидаемый результат:
Название гонки
Сезон
Общее количество обгонов

Автор: Акнур Оразбай
Проект: Платформа оценки эффективности Гран-при
==========================================================
*/
/*
Business question: Which Grands Prix show the strongest overall performance?
KPI: Grand Prix Performance Score (proxy)
Score = normalized position gain + finish rate + normalized competitive movement.
Note: historical dataset does not contain audience/viewership/commercial success.
*/
WITH race_metrics AS (
    SELECT
        r.race_id,
        r.year,
        r.name AS grand_prix,
        r.circuit_id,
        COUNT(*) FILTER (WHERE res.position_order > 0) AS classified_finishers,
        COUNT(*) AS starters,
        SUM(GREATEST(res.grid - res.position_order, 0))
            FILTER (WHERE res.grid > 0 AND res.position_order > 0) AS position_gain,
        AVG(ABS(res.grid - res.position_order))
            FILTER (WHERE res.grid > 0 AND res.position_order > 0) AS avg_position_movement
    FROM races r
    JOIN results res ON res.race_id = r.race_id
    GROUP BY r.race_id, r.year, r.name, r.circuit_id
),
scored AS (
    SELECT *,
           classified_finishers::numeric / NULLIF(starters, 0) AS finish_rate,
           PERCENT_RANK() OVER (ORDER BY position_gain) AS gain_score,
           PERCENT_RANK() OVER (ORDER BY avg_position_movement) AS movement_score
    FROM race_metrics
)
SELECT
    year,
    grand_prix,
    starters,
    classified_finishers,
    ROUND((finish_rate * 100)::numeric, 1) AS finish_rate_pct,
	position_gain,
	ROUND(avg_position_movement::numeric, 2) AS avg_position_movement,
	ROUND(
    	((gain_score * 0.4 + finish_rate * 0.3 + movement_score * 0.3) * 100)::numeric,
    	1
	) AS grand_prix_performance_score
FROM scored
ORDER BY grand_prix_performance_score DESC, year DESC;
