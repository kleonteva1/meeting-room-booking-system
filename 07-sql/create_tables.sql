-- DDL

CREATE TABLE users (
    id_user INT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    position VARCHAR(100)
);

CREATE TABLE rooms (
    id_room INT PRIMARY KEY,
    room_name VARCHAR(40) NOT NULL,
    capacity INT NOT NULL CHECK (capacity > 0),
    has_flipchart BOOLEAN NOT NULL,
    has_projector BOOLEAN NOT NULL
);

CREATE TABLE bookings (
    id_booking INT PRIMARY KEY,
    id_user INT NOT NULL,
    id_room INT NOT NULL,
    participant_count INT NOT NULL CHECK (participant_count > 0),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    start_datetime TIMESTAMP NOT NULL,
    finish_datetime TIMESTAMP NOT NULL,
    status VARCHAR(20) NOT NULL CHECK (status IN ('ACTIVE', 'CANCELLED')),
    FOREIGN KEY (id_user) REFERENCES users(id_user),
    FOREIGN KEY (id_room) REFERENCES rooms(id_room),
    CHECK (finish_datetime > start_datetime)
);

-- DML

INSERT INTO users (id_user, full_name, phone, email, position) VALUES
    (1, 'Анна Смирнова', '+79990000001', 'anna@example.com', 'Аналитик'),
    (2, 'Иван Петров', '+79990000002', 'ivan@example.com', 'Разработчик'),
    (3, 'Мария Соколова', '+79990000003', 'maria@example.com', 'Менеджер'),
    (4, 'Дмитрий Иванов', '+79990000004', 'dmitry@example.com', 'Тестировщик'),
    (5, 'Елена Кузнецова', '+79990000005', 'elena@example.com', 'Дизайнер'),
    (6, 'Алексей Морозов', '+79990000006', 'alexey@example.com', 'Разработчик'),
    (7, 'Ольга Волкова', '+79990000007', 'olga@example.com', 'Менеджер'),
    (8, 'Сергей Орлов', '+79990000008', 'sergey@example.com', 'Аналитик');

INSERT INTO rooms (id_room, room_name, capacity, has_flipchart, has_projector) VALUES
    (1, 'Красная', 4, TRUE, FALSE),
    (2, 'Синяя', 4, TRUE, FALSE),
    (3, 'Фиолетовая', 15, TRUE, TRUE),
    (4, 'Зелёная', 10, TRUE, FALSE),
    (5, 'Жёлтая', 6, FALSE, TRUE);
