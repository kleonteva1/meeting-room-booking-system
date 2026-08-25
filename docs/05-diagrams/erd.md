# ERD

Модель данных системы состоит из 3 основных сущностей: пользователи, переговорные комнаты и бронирования.

## Связи между таблицами

```text
users (1) ──────< (N) bookings (N) >────── (1) rooms
```

- `users 1:N bookings` - один пользователь может иметь несколько бронирований, каждое бронирование принадлежит одному пользователю.
- `rooms 1:N bookings` - одна переговорная комната может иметь несколько бронирований, каждое бронирование относится к одной комнате.

Связи реализованы с помощью внешних ключей:
- `bookings.id_user` → `users.id_user`
- `bookings.id_room` → `rooms.id_room`

## Таблица `users`

Хранит информацию о сотрудниках компании.

| Поле | Тип данных | Ограничения | Описание |
| --- | --- | --- | --- |
| `id_user` | INT | PRIMARY KEY | Уникальный идентификатор пользователя |
| `full_name` | VARCHAR(255) | NOT NULL | ФИО пользователя |
| `phone` | VARCHAR(20) | NOT NULL, UNIQUE | Номер телефона |
| `email` | VARCHAR(255) | NOT NULL, UNIQUE | Электронная почта |
| `position` | VARCHAR(100) | — | Должность сотрудника |

## Таблица `rooms`

Хранит информацию о переговорных комнатах и их характеристиках.

| Поле | Тип данных | Ограничения | Описание |
| --- | --- | --- | --- |
| `id_room` | INT | PRIMARY KEY | Уникальный идентификатор комнаты |
| `room_name` | VARCHAR(40) | NOT NULL | Название комнаты |
| `capacity` | INT | NOT NULL, CHECK (`capacity > 0`) | Максимальная вместимость комнаты |
| `has_flipchart` | BOOLEAN | NOT NULL | Наличие флипчарта |
| `has_projector` | BOOLEAN | NOT NULL | Наличие проектора |

## Таблица `bookings`

Хранит информацию о созданных бронированиях переговорных комнат.

| Поле | Тип данных | Ограничения | Описание |
| --- | --- | --- | --- |
| `id_booking` | INT | PRIMARY KEY | Уникальный идентификатор бронирования |
| `id_user` | INT | NOT NULL, FOREIGN KEY | Идентификатор пользователя, создавшего бронирование |
| `id_room` | INT | NOT NULL, FOREIGN KEY | Идентификатор забронированной комнаты |
| `participant_count` | INT | NOT NULL, CHECK (`participant_count > 0`) | Количество участников |
| `created_at` | TIMESTAMP | NOT NULL | Дата и время создания бронирования |
| `start_datetime` | TIMESTAMP | NOT NULL | Дата и время начала бронирования |
| `finish_datetime` | TIMESTAMP | NOT NULL | Дата и время окончания бронирования |
| `status` | VARCHAR(20) | NOT NULL, CHECK (`status IN ('ACTIVE', 'CANCELLED')`) | Статус бронирования |
