Анализ бизнес-требований (Business Question Mapping)
Цель
Определить, какие данные, таблицы, поля и показатели необходимы для ответа на каждый бизнес-вопрос, поставленный Formula One Management.

## 3.1 Анализ эффективности этапов

| Бизнес-вопрос                                            | Таблицы                                    | Основные поля                             | KPI                          |
| -------------------------------------------------------- | ------------------------------------------ | ----------------------------------------- | ---------------------------- |
| Какие Гран-при являются наиболее успешными?              | races, circuits, results, driver_standings | raceId, circuitId, points, laps, position | Grand Prix Performance Score |
| Какие трассы наиболее конкурентны?                       | races, results, lap_times                  | raceId, position, milliseconds            | Competitiveness Index        |
| Какие этапы демонстрируют наибольшее количество обгонов? | lap_times, results                         | driverId, lap, position                   | Number of Overtakes          |
| Какие этапы имеют наибольшее количество сходов?          | results, status                            | statusId                                  | DNF Rate                     |
| Какие этапы наиболее предсказуемы?                       | qualifying, results                        | grid, positionOrder                       | Predictability Index         |

---

## 3.2 Анализ пилотов

| Бизнес-вопрос                                                  | Таблицы                           | Основные поля               | KPI                       |
| -------------------------------------------------------------- | --------------------------------- | --------------------------- | ------------------------- |
| Какие пилоты демонстрируют наиболее стабильные результаты?     | drivers, results                  | positionOrder, points       | Driver Consistency Score  |
| Какие пилоты чаще выигрывают после старта не с первой позиции? | qualifying, results               | grid, positionOrder         | Wins from Non-Pole        |
| Какие пилоты чаще всего улучшают стартовую позицию?            | qualifying, results               | grid, positionOrder         | Average Position Gain     |
| Какие пилоты наиболее успешны на определенных трассах?         | drivers, circuits, races, results | circuitId, driverId, points | Circuit Performance Index |

---

## 3.3 Анализ команд

| Бизнес-вопрос                                             | Таблицы                             | Основные поля  | KPI                    |
| --------------------------------------------------------- | ----------------------------------- | -------------- | ---------------------- |
| Какие команды доминировали в разные периоды?              | constructors, constructor_standings | points, wins   | Team Dominance Index   |
| Какие команды демонстрируют устойчивый рост результатов?  | constructor_standings               | season, points | Growth Rate            |
| Какие команды наиболее эффективны в квалификации?         | qualifying, constructors            | grid           | Qualifying Performance |
| Какие команды имеют лучшую реализацию гоночной стратегии? | pit_stops, results                  | stop, duration | Strategy Efficiency    |

---

## 3.4 Анализ трасс

| Бизнес-вопрос                                         | Таблицы                             | Основные поля  | KPI                       |
| ----------------------------------------------------- | ----------------------------------- | -------------- | ------------------------- |
| Какие трассы являются наиболее зрелищными?            | circuits, races, lap_times, results | laps, position | Spectacle Score           |
| Какие трассы чаще приводят к сходам?                  | results, status                     | statusId       | DNF Percentage            |
| Какие трассы наиболее сложны для обгонов?             | lap_times, results                  | position       | Overtake Difficulty Index |
| Какие трассы наиболее стабильны по результатам гонок? | results                             | positionOrder  | Race Stability Index      |

---

## 3.5 Анализ чемпионата

| Бизнес-вопрос                                            | Таблицы                                 | Основные поля  | KPI                              |
| -------------------------------------------------------- | --------------------------------------- | -------------- | -------------------------------- |
| Как изменялся уровень конкуренции между сезонами?        | seasons, results, driver_standings      | season, points | Season Competitiveness Index     |
| Как изменялось количество победителей?                   | races, results                          | winner         | Number of Unique Winners         |
| Какие сезоны были наиболее конкурентными?                | driver_standings, constructor_standings | points         | Season Balance Score             |
| Какие изменения происходили после изменения регламентов? | seasons, results                        | season         | Before/After Regulation Analysis |

---

