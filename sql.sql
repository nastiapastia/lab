CREATE TABLE users
(
    id       INT AUTO_INCREMENT PRIMARY KEY,
    name     VARCHAR(100)        NOT NULL,
    email    VARCHAR(255) UNIQUE NOT NULL,
    password TEXT                NOT NULL,
    role     ENUM('client', 'employee', 'supplier', 'admin') NOT NULL,
    phone    VARCHAR(20) UNIQUE  NOT NULL
);

CREATE TABLE fruits
(
    id                     INT AUTO_INCREMENT PRIMARY KEY,
    name                   VARCHAR(100) NOT NULL,
    refrigeration_required BOOLEAN      NOT NULL DEFAULT FALSE,
    image_url              TEXT,
    description            TEXT
);

CREATE TABLE countries
(
    id   INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE streets
(
    id                    INT AUTO_INCREMENT PRIMARY KEY,
    name                  VARCHAR(255) NOT NULL UNIQUE,
    delivery_time_minutes INT          NOT NULL CHECK (delivery_time_minutes > 0)
);

CREATE TABLE addresses
(
    id        INT AUTO_INCREMENT PRIMARY KEY,
    user_id   INT         NOT NULL,
    street_id INT         NOT NULL,
    building  VARCHAR(20) NOT NULL,
    apartment VARCHAR(10),
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    FOREIGN KEY (street_id) REFERENCES streets (id) ON DELETE CASCADE
);

CREATE TABLE fruit_prices
    id INT AUTO_INCREMENT PRIMARY KEY,
    fruit_id INT NOT NULL,
    country_id INT NOT NULL,
    income_price DECIMAL (10, 2) NOT NULL CHECK(income_price >= 0),
    out_price DECIMAL(10,2) NOT NULL CHECK(out_price >= 0),
    initial_quantity INT NOT NULL CHECK(initial_quantity > 0),
    current_quantity INT NOT NULL CHECK(current_quantity >= 0),
    unit ENUM('kg', 'pcs', 'liters') NOT NULL,
    supplier_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_by INT,
    deleted_at TIMESTAMP NULL,
    FOREIGN KEY(fruit_id) REFERENCES fruits(id) ON DELETE CASCADE,
    FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE CASCADE,
    FOREIGN KEY (supplier_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL
);

CREATE TABLE orders
(
    id         INT AUTO_INCREMENT PRIMARY KEY,
    user_id    INT NOT NULL,
    address_id INT NOT NULL,
    status     ENUM('pending', 'processing', 'shipped', 'delivered', 'cancelled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    FOREIGN KEY (address_id) REFERENCES addresses (id) ON DELETE CASCADE
);


CREATE TABLE order_items
(
    id             INT AUTO_INCREMENT PRIMARY KEY,
    order_id       INT NOT NULL,
    fruit_price_id INT NOT NULL,
    quantity       INT NOT NULL CHECK (quantity > 0),
    FOREIGN KEY (order_id) REFERENCES orders (id) ON DELETE CASCADE,
    FOREIGN KEY (fruit_price_id) REFERENCES fruit_prices (id) ON DELETE CASCADE
);

CREATE TABLE payments
(
    id             INT AUTO_INCREMENT PRIMARY KEY,
    order_id       INT NOT NULL,
    method         ENUM('card', 'cash', 'paypal') NOT NULL,
    status         ENUM('pending', 'completed', 'failed', 'refunded') NOT NULL,
    transaction_id VARCHAR(100),
    created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders (id) ON DELETE CASCADE
);

INSERT INTO users (name, email, password, role, phone) VALUES
-- 🔹 2 Адміністратори (🇬🇧 Англія)
('William Johnson', 'william.johnson@example.com', 'securepassword1', 'admin', '+44 7911 123456'),
('Elizabeth Smith', 'elizabeth.smith@example.com', 'securepassword2', 'admin', '+44 7911 123457'),

-- 🔹 3 Працівники (🇩🇪 Німеччина)
('Sebastian Müller', 'sebastian.mueller@example.com', 'securepassword3', 'employee', '+49 151 2345678'),
('Johanna Schmidt', 'johanna.schmidt@example.com', 'securepassword4', 'employee', '+49 151 2345679'),
('Lukas Wagner', 'lukas.wagner@example.com', 'securepassword5', 'employee', '+49 151 2345680'),

-- 🔹 5 Постачальників (🇪🇸 Іспанія)
('Carlos García', 'carlos.garcia@example.com', 'securepassword6', 'supplier', '+34 612 345 678'),
('María Rodríguez', 'maria.rodriguez@example.com', 'securepassword7', 'supplier', '+34 612 345 679'),
('Javier Fernández', 'javier.fernandez@example.com', 'securepassword8', 'supplier', '+34 612 345 680'),
('Lucía Martínez', 'lucia.martinez@example.com', 'securepassword9', 'supplier', '+34 612 345 681'),
('Andrés López', 'andres.lopez@example.com', 'securepassword10', 'supplier', '+34 612 345 682'),

-- 🔹 20 Клієнтів (🇬🇧 🇩🇪 🇪🇸)
('James Brown', 'james.brown@example.com', 'securepassword11', 'client', '+44 7911 123458'),
('Sophie Taylor', 'sophie.taylor@example.com', 'securepassword12', 'client', '+44 7911 123459'),
('Alexander Hoffmann', 'alexander.hoffmann@example.com', 'securepassword13', 'client', '+49 151 2345681'),
('Emma Fischer', 'emma.fischer@example.com', 'securepassword14', 'client', '+49 151 2345682'),
('Leon Becker', 'leon.becker@example.com', 'securepassword15', 'client', '+49 151 2345683'),
('Daniela Ruiz', 'daniela.ruiz@example.com', 'securepassword16', 'client', '+34 612 345 683'),
('Hugo Navarro', 'hugo.navarro@example.com', 'securepassword17', 'client', '+34 612 345 684'),
('Isabella Ortega', 'isabella.ortega@example.com', 'securepassword18', 'client', '+34 612 345 685'),
('Oliver White', 'oliver.white@example.com', 'securepassword19', 'client', '+44 7911 123460'),
('Amelia Harris', 'amelia.harris@example.com', 'securepassword20', 'client', '+44 7911 123461'),
('Maximilian König', 'maximilian.koenig@example.com', 'securepassword21', 'client', '+49 151 2345684'),
('Charlotte Meier', 'charlotte.meier@example.com', 'securepassword22', 'client', '+49 151 2345685'),
('Benjamin Krüger', 'benjamin.krueger@example.com', 'securepassword23', 'client', '+49 151 2345686'),
('Victoria González', 'victoria.gonzalez@example.com', 'securepassword24', 'client', '+34 612 345 686'),
('Samuel Castro', 'samuel.castro@example.com', 'securepassword25', 'client', '+34 612 345 687'),
('Elena Morales', 'elena.morales@example.com', 'securepassword26', 'client', '+34 612 345 688'),
('Henry Martin', 'henry.martin@example.com', 'securepassword27', 'client', '+44 7911 123462'),
('Lucy Wilson', 'lucy.wilson@example.com', 'securepassword28', 'client', '+44 7911 123463'),
('Julian Lehmann', 'julian.lehmann@example.com', 'securepassword29', 'client', '+49 151 2345687'),
('Marta Sánchez', 'marta.sanchez@example.com', 'securepassword30', 'client', '+34 612 345 689');

INSERT INTO streets (name, delivery_time_minutes) VALUES
      ('Грушевського', 33),
      ('Мазепи', 40),
      ('Січових Стрільців', 12),
      ('Бандери', 30),
      ('Незалежності', 11),
      ('Шевченка', 32),
      ('Чорновола', 36),
      ('Довженка', 50),
      ('Хоткевича', 10),
      ('Коновальця', 36),
      ('Вовчинецька', 19),
      ('Мельника', 32),
      ('Лепкого', 43),
      ('Галицька', 45),
      ('Кисілевської', 6),
      ('Пулюя', 15),
      ('Карпатська', 26),
      ('Залізнична', 39),
      ('Крихівецька', 25),
      ('Тролейбусна', 19);


INSERT INTO countries (name) VALUES
    ('Бразилія'),
    ('Індія'),
    ('Мексика'),
    ('Індонезія'),
    ('Китай'),
    ('Колумбія'),
    ('Таїланд'),
    ('Єгипет'),
    ('Туреччина'),
    ('Філіппіни'),
    ('ПАР'),
    ('Іран'),
    ('В`єтнам'),
    ('Малайзія'),
    ('Іспанія'),
    ('Італія'),
    ('Греція'),
    ('США'),
    ('Чилі'),
    ('Аргентина');

INSERT INTO fruits (name, refrigeration_required, image_url, description) VALUES
-- 🔸 Апельсин імпортний
('Апельсин імпортний', FALSE, 'apelsin-imp-500x500.png', 'Апельсин — популярний цитрусовий фрукт, багатий на вітамін C. Має солодкий та соковитий смак.'),
-- 🔸 Апельсин Кара-Кара
('Апельсин Кара-Кара', FALSE, 'apelsin-kara-kara__188-500x500.png', 'Апельсин сорту Кара-Кара відомий своїм червонуватим відтінком м’якоті та солодким смаком.'),
-- 🔸 Апельсин Сицилія імпортний
('Апельсин Сицилія імпортний', FALSE, 'apelsin-siciliya-imp-500x500.png', 'Сицилійський апельсин, також відомий як «кривавий апельсин», має насичений червоний колір м’якоті та особливий смак.'),
-- 🔸 Лайм імпортний
('Лайм імпортний', TRUE, 'laim-imp-500x500.png', 'Лайм — невеликий зелений цитрусовий фрукт з кислим смаком, часто використовується в кулінарії та напоях.'),
-- 🔸 Лимон імпортний
('Лимон імпортний', TRUE, 'limon-imp-500x500.png', 'Лимон — жовтий цитрусовий фрукт з кислим смаком, багатий на вітамін C. Використовується в багатьох стравах та напоях.'),
-- 🔸 Мандарин Айшан імпортний
('Мандарин Айшан імпортний', FALSE, 'mandarin-aixan-imp-500x500.png', 'Мандарин сорту Айшан відомий своєю солодкістю та легкою очищуваністю.'),
-- 🔸 Мандарин Джаффа імпортний
('Мандарин Джаффа імпортний', FALSE, 'mandarin-dzaffa-imp__695-500x500.png', 'Мандарин сорту Джаффа має соковиту м’якоть та насичений аромат.'),
-- 🔸 Мандарин імпортний
('Мандарин імпортний', FALSE, 'mandarin-imp-500x500.png', 'Мандарин — солодкий цитрусовий фрукт, легко очищується та часто споживається свіжим.'),
-- 🔸 Помело імпортний
('Помело імпортний', TRUE, 'pomelo-imp-500x500.png', 'Помело — найбільший цитрусовий фрукт з товстою шкіркою та солодко-кислим смаком.'),
-- 🔸 Світті імпортний
('Світті імпортний', TRUE, 'sviti-imp-500x500.png', 'Світті — гібрид помело та грейпфрута, має солодкий смак без гіркоти, характерної для грейпфрута.');
