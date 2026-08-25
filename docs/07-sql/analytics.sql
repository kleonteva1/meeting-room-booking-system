-- Самые популярные комнаты
SELECT room_name, COUNT(id_booking) AS count_booking
FROM rooms r
LEFT JOIN bookings b
ON r.id_room=b.id_room
GROUP BY r.id_room, room_name
ORDER BY count_booking DESC;


-- Средняя длительность бронирования по комнатам
SELECT room_name, AVG(finish_datetime-start_datetime) AS avg_duration
FROM rooms r
LEFT JOIN bookings b
ON r.id_room=b.id_room
GROUP BY r.id_room, room_name
ORDER BY avg_duration DESC;


-- Какие должности сотрудников чаще бронируют переговорные
SELECT position, COUNT(id_booking) AS count_booking
FROM users u
LEFT JOIN bookings b
ON u.id_user=b.id_user
GROUP BY position
ORDER BY count_booking DESC;


-- Количество активных бронирований по дням недели
WITH booking_by_day AS (
SELECT EXTRACT(ISODOW FROM start_datetime) AS day_number, COUNT(id_booking) AS count_booking
FROM bookings
WHERE status='ACTIVE'
GROUP BY day_number)

SELECT CASE
WHEN day_number=1 THEN 'Понедельник'
WHEN day_number=2 THEN 'Вторник'
WHEN day_number=3 THEN 'Среда'
WHEN day_number=4 THEN 'Четверг'
WHEN day_number=5 THEN 'Пятница'
WHEN day_number=6 THEN 'Суббота'
WHEN day_number=7 THEN 'Воскресенье'
END AS day, count_booking
FROM booking_by_day
ORDER BY day_number;


-- Комнаты, которые ни разу не бронировали
SELECT room_name
FROM rooms r
WHERE NOT EXISTS (
SELECT 1
FROM bookings b
WHERE r.id_room=b.id_room);


-- Самая популярная комната среди сотрудников каждой должности
WITH room_rating AS (
SELECT position, room_name, COUNT(id_booking) AS count_booking
FROM users u
JOIN bookings b
ON u.id_user=b.id_user
JOIN rooms r
ON b.id_room=r.id_room
GROUP BY position, r.id_room, room_name),

max_rating AS (
SELECT position, MAX(count_booking) AS max_booking
FROM room_rating
GROUP BY position)

SELECT rr.position, rr.room_name, rr.count_booking
FROM room_rating rr
JOIN max_rating mr
ON rr.position=mr.position
WHERE rr.count_booking=mr.max_booking
ORDER BY rr.position ASC;
