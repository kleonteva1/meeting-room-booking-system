-- Получение информации о комнате
SELECT room_name, capacity, has_flipchart, has_projector
FROM rooms
WHERE id_room=3;


-- Получение подходящих комнат и занятых часовых интервалов на выбранную дату
SELECT r.id_room, room_name, capacity, has_flipchart, has_projector, CAST(start_datetime AS TIME) AS start_time, CAST(finish_datetime AS TIME) AS finish_time
FROM rooms r
LEFT JOIN bookings b
ON r.id_room=b.id_room AND CAST(start_datetime AS DATE)='2026-08-24' AND status='ACTIVE'
WHERE capacity>=8 AND has_flipchart=TRUE
ORDER BY r.id_room, start_datetime;


-- Поиск вариантов на ближайшие даты
SELECT r.id_room, room_name, capacity, has_flipchart, has_projector, start_datetime, finish_datetime
FROM rooms r
LEFT JOIN bookings b
ON r.id_room=b.id_room AND CAST(start_datetime AS DATE) IN ('2026-08-24', '2026-08-26') AND status='ACTIVE'
WHERE capacity>=8 AND has_flipchart=TRUE
ORDER BY r.id_room, start_datetime;


-- Проверка доступности комнаты перед бронированием
SELECT id_booking
FROM bookings
WHERE id_room=3 AND status='ACTIVE' AND start_datetime<'2026-08-24 12:00:00' AND finish_datetime>'2026-08-24 10:00:00';


-- Создание нового бронирования
INSERT INTO bookings (id_booking, id_user, id_room, participant_count, created_at, start_datetime, finish_datetime, status) VALUES
(41, 2, 3, 8, '2026-08-23 14:00:00', '2026-08-24 10:00:00', '2026-08-24 12:00:00', 'ACTIVE');


-- Получение собственных бронирований пользователя
SELECT id_booking, room_name, participant_count, created_at, start_datetime, finish_datetime, status
FROM bookings b
JOIN rooms r
ON b.id_room=r.id_room
WHERE id_user=2
ORDER BY id_booking;


-- Изменение бронирования
UPDATE bookings SET participant_count=5, start_datetime='2026-08-24 17:00:00'
WHERE id_booking=7 AND id_user=2 AND status='ACTIVE';


-- Отмена бронирования
UPDATE bookings SET status='CANCELLED'
WHERE id_booking=15 AND id_user=6 AND status='ACTIVE';
