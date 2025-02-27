-- Create tables in correct order due to foreign key dependencies

-- Independent tables first
CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_group VARCHAR(255) NOT NULL,
    category VARCHAR(255) NOT NULL,
    sub_category VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER
);

CREATE TABLE cities (
    city_id SERIAL PRIMARY KEY,
    city_name VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER
);

CREATE TABLE channels (
    channel_id SERIAL PRIMARY KEY,
    channel_name VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER
);

CREATE TABLE brands (
    brand_id SERIAL PRIMARY KEY,
    brand_name VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER
);

CREATE TABLE suppliers (
    supplier_id INTEGER PRIMARY KEY,  -- Changed to INTEGER to match data
    supplier_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER
);

CREATE TABLE role (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER
);

-- Dependent tables
CREATE TABLE banner (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    image VARCHAR(255) NOT NULL,
    status BOOLEAN NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    code VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    role INTEGER NOT NULL,
    image VARCHAR(255) NOT NULL,
    status BOOLEAN NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    FOREIGN KEY (role) REFERENCES role(id) ON DELETE RESTRICT
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    price DECIMAL(10,2) NOT NULL,
    status BOOLEAN DEFAULT true,
    images INTEGER,
    product_code VARCHAR(255),
    unit VARCHAR(255),
    barcode BIGINT NOT NULL,
    brand_id INTEGER,
    category_id INTEGER,
    supplier_id INTEGER,
    article VARCHAR(255) NOT NULL,
    sale_price DECIMAL(10,2),
    image_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    FOREIGN KEY (brand_id) REFERENCES brands(brand_id) ON DELETE SET NULL,
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE SET NULL,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id) ON DELETE SET NULL
);

CREATE TABLE stores (
    store_id INTEGER PRIMARY KEY,  -- Changed to INTEGER to match data
    store_name VARCHAR(255) NOT NULL,
    city_id INTEGER NOT NULL,
    channel_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    FOREIGN KEY (city_id) REFERENCES cities(city_id) ON DELETE RESTRICT,
    FOREIGN KEY (channel_id) REFERENCES channels(channel_id) ON DELETE RESTRICT
);

CREATE TABLE sale (
    sales_id SERIAL PRIMARY KEY,
    period_month VARCHAR(255) NOT NULL,
    store_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    value DECIMAL(10,2) NOT NULL,
    qty INTEGER NOT NULL,
    margin_value DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER,
    FOREIGN KEY (store_id) REFERENCES stores(store_id) ON DELETE RESTRICT,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE RESTRICT
);

CREATE TABLE cart (
    id SERIAL PRIMARY KEY,
    product_code VARCHAR(255) NOT NULL,
    user_code VARCHAR(255) NOT NULL,
    quantity INTEGER NOT NULL,
    discount DECIMAL(10,2) NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    detail TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER
);

CREATE TABLE payment_transaction (
    id SERIAL PRIMARY KEY,
    client_code VARCHAR(255) NOT NULL,
    admin_code VARCHAR(255) NOT NULL,
    cart_code VARCHAR(255) NOT NULL,
    payment_code VARCHAR(255) UNIQUE NOT NULL,
    payment_type VARCHAR(255) NOT NULL,
    images VARCHAR(255),
    status VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    client_code VARCHAR(255) NOT NULL,
    admin_code VARCHAR(255) NOT NULL,
    cart_code VARCHAR(255) NOT NULL,
    payment_code VARCHAR(255) NOT NULL,
    detail VARCHAR(255) NOT NULL,
    status VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER
);

CREATE TABLE logs (
    id SERIAL PRIMARY KEY,
    event_type VARCHAR(255) NOT NULL,
    event_detail VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER
);

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INTEGER,
    updated_by INTEGER
);

-- Insert statements with fixes
INSERT INTO categories (category_group, category, sub_category) VALUES
('MEAT', 'HAM', 'SWEET HAM'),
('MEAT', 'HAM', 'COOKED HAM'),
('MEAT', 'HAM', 'RAW HAM'),
('MEAT', 'BEEF', 'PRE-PACKED FROZEN'),
('CANDIES', 'GUMS', 'GUMS TRADITIONAL'),
('CANDIES', 'GUMS', 'GUMS FRUIT')
ON CONFLICT DO NOTHING;

INSERT INTO cities (city_name) VALUES
('HOUSTON'),
('MANDAON MASBATE'),
('RICHMOND'),
('BATON ROUGE'),
('ATLANTA'),
('NORFOLK'),
('NEW ORLEANS'),
('TABACO CITY'),
('SORSOGON'),
('POLANGUI ALBAY'),
('CAMARINES NORTE'),
('ORLANDO'),
('CAMARINES SUR'),
('MILAGROS MASBATE'),
('BOERNE'),
('SAVANNAH'),
('FORT LAUDERDALE'),
('TAMPA'),
('KEY WEST'),
('ROANOKE'),
('EUFAULA'),
('PLACER MASBATE CITY'),
('RALEIGH'),
('AUSTIN'),
('JACKSONVILLE'),
('EL PASO'),
('NAGA CITY'),
('MOBILE'),
('NASHVILLE'),
('MEMPHIS'),
('MYRTLE BEACH'),
('SAN ANTONIO'),
('WALTERBORO'),
('MIAMI'),
('WEST PALM BEACH'),
('PHOENIX'),
('KEY LARGO'),
('BIRMINGHAM'),
('TAGKAWAYAN QUEZON'),
('VIRGINIA BEACH'),
('COLUMBIA'),
('CAWAYAN MASBATE'),
('DARAGA ALBAY'),
('LOUISVILLE'),
('NATCHITOCHES'),
('CHATTANOOGA'),
('LEXINGTON'),
('BACACAY ALBAY'),
('CORPUS CHRISTI'),
('DALLAS'),
('LITTLE ROCK')
ON CONFLICT DO NOTHING;

INSERT INTO channels (channel_name) VALUES
('BIGMART'),
('SUPERMARKET'),
('CONVENIENCE'),
('ONLINE'),
('EXPRESS MART'),
('SUPERSTORE'),
('MARKET PLUS')
ON CONFLICT DO NOTHING;

INSERT INTO brands (brand_name) VALUES
('BRAND 152'),
('BRAND 1039'),
('BRAND 288'),
('BRAND 1'),
('BRAND 423'),
('BRAND 716'),
('BRAND 714'),
('BRAND 615')
ON CONFLICT DO NOTHING;

INSERT INTO suppliers (supplier_id, supplier_name) VALUES
(70100, 'FOODSPHERE INC.'),
(70213, 'FOODSPHERE INC.-CDO HAM'),
(170258, 'PAXXIS DIST.-PUREFOODS HOTDOG'),
(170141, 'PTC COMMERCIAL CORPORATION'),
(80400, 'GLOBAL ESSENTIAL FOODS INC.'),
(30900, 'BOX AND BASICS DIST. INC. - WRIGLEY'),
(50117, 'DVM ENTERPRISES-REBISCO')
ON CONFLICT (supplier_id) DO UPDATE SET supplier_name = EXCLUDED.supplier_name;

INSERT INTO products (name, price, barcode, brand_id, category_id, supplier_id, article) VALUES
('Brand 152 Article 1 Piece', 235.33, 2100008, 
    (SELECT brand_id FROM brands WHERE brand_name = 'BRAND 152'),
    (SELECT category_id FROM categories WHERE category_group = 'MEAT' AND category = 'HAM' AND sub_category = 'SWEET HAM'),
    70100,
    'Brand 152 Article 1 Piece'),
('Brand 152 Article 1 Piece', 289.00, 4800249002867, 
    (SELECT brand_id FROM brands WHERE brand_name = 'BRAND 152'),
    (SELECT category_id FROM categories WHERE category_group = 'MEAT' AND category = 'HAM' AND sub_category = 'COOKED HAM'),
    70213,
    'Brand 152 Article 1 Piece'),
('Brand 1039 Article 1 Piece', 65.25, 4808887320022, 
    (SELECT brand_id FROM brands WHERE brand_name = 'BRAND 1039'),
    (SELECT category_id FROM categories WHERE category_group = 'MEAT' AND category = 'HAM' AND sub_category = 'RAW HAM'),
    170258,
    'Brand 1039 Article 1 Piece'),
('Brand 1 Article 1 Piece', 490.15, 4800282005436, 
    (SELECT brand_id FROM brands WHERE brand_name = 'BRAND 1'),
    (SELECT category_id FROM categories WHERE category_group = 'MEAT' AND category = 'BEEF' AND sub_category = 'PRE-PACKED FROZEN'),
    170141,
    'Brand 1 Article 1 Piece'),
('Brand 423 Article 1 Piece', 67.75, 22000111364, 
    (SELECT brand_id FROM brands WHERE brand_name = 'BRAND 423'),
    (SELECT category_id FROM categories WHERE category_group = 'CANDIES' AND category = 'GUMS' AND sub_category = 'GUMS TRADITIONAL'),
    30900,
    'Brand 423 Article 1 Piece'),
('Brand 615 Article 1 Piece', 24.20, 4800103345048, 
    (SELECT brand_id FROM brands WHERE brand_name = 'BRAND 615'),
    (SELECT category_id FROM categories WHERE category_group = 'CANDIES' AND category = 'GUMS' AND sub_category = 'GUMS FRUIT'),
    50117,
    'Brand 615 Article 1 Piece')
ON CONFLICT (barcode) DO NOTHING;

INSERT INTO stores (store_id, store_name, city_id, channel_id) VALUES
(657, 'RIVER OAKS RETAIL', 
    (SELECT city_id FROM cities WHERE city_name = 'HOUSTON'),
    (SELECT channel_id FROM channels WHERE channel_name = 'BIGMART')),
(13894, 'MANDAON SUPERMARKET STORE', 
    (SELECT city_id FROM cities WHERE city_name = 'MANDAON MASBATE'),
    (SELECT channel_id FROM channels WHERE channel_name = 'SUPERMARKET')),
(716, 'RIVER DISTRICT RETAIL', 
    (SELECT city_id FROM cities WHERE city_name = 'RICHMOND'),
    (SELECT channel_id FROM channels WHERE channel_name = 'BIGMART')),
(714, 'BAYOU BAZAAR', 
    (SELECT city_id FROM cities WHERE city_name = 'BATON ROUGE'),
    (SELECT channel_id FROM channels WHERE channel_name = 'SUPERMARKET')),
(770, 'STARLIGHT SUPERSTORE', 
    (SELECT city_id FROM cities WHERE city_name = 'ATLANTA'),
    (SELECT channel_id FROM channels WHERE channel_name = 'BIGMART'))
ON CONFLICT (store_id) DO UPDATE SET store_name = EXCLUDED.store_name,
                                    city_id = EXCLUDED.city_id,
                                    channel_id = EXCLUDED.channel_id;

INSERT INTO sale (period_month, store_id, product_id, value, qty, margin_value) VALUES
('2022-05', 657, 
    (SELECT id FROM products WHERE barcode = 2100008),
    235.33, 1, 10.94),
('2022-05', 13894, 
    (SELECT id FROM products WHERE barcode = 4800249002867),
    289.00, 1, 14.45),
('2022-05', 716, 
    (SELECT id FROM products WHERE barcode = 4800249023756),
    149.00, 1, 7.45),
('2022-05', 714, 
    (SELECT id FROM products WHERE barcode = 4800249043815),
    2215.46, 21, 401.06),
('2022-05', 770, 
    (SELECT id FROM products WHERE barcode = 4800249043815),
    1215.91, 12, 179.11);