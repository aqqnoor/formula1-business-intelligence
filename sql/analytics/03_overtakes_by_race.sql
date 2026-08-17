/*
==========================================================
Файл: 03_overtakes_by_race.sql

Бизнес-вопрос:
На каком Гран-при было зафиксировано наибольшее количество обгонов?

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

SELECT
    ra.name AS grand_prix,
    COUNT(DISTINCT ra.race_id) AS races_held,
    SUM(
        CASE
            WHEN r.grid > r.position_order
            THEN r.grid - r.position_order
            ELSE 0
        END
    ) AS total_overtakes,
    ROUND(
        AVG(
            CASE
                WHEN r.grid > r.position_order
                THEN r.grid - r.position_order
                ELSE 0
            END
        ),
        2
    ) AS avg_overtakes_per_driver
FROM results r
JOIN races ra
    ON r.race_id = ra.race_id
WHERE
    r.grid > 0
    AND r.position_order > 0
GROUP BY
    ra.name
ORDER BY
    total_overtakes DESC limit 1;