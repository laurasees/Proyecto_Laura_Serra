## Esquema de la Base de Datos

ACTOR {
int actor_id PK
varchar first_name
varchar last_name
timestamp last_update
}

ADRESS{
int adress_id PK
varchar adress
varchar adress2
int city_id FK
varchar postal_code
varchar phone
timestamp last_update
}

CATEGORY {
int category_id PK
varchar name
timestamp last_update
}

CITY {
int city_id PK
varchar city
int country_id FK
timestamp last_update
}

COUNTRY {
int country_id PK
varchar country
timestamp last_update
}

CUSTOMER {
int customer_id PK
int store_id FK
varchar first_name
varchar last_name
varchar email
int adress_id FK
bool activebool
date create_date
timestamp last_update
int active
}

FILM {
int film_id PK
varchar title
text description
int release_year
int language_id FK
int original_language_id
int rental_duration 
numeric rental_rate
int length
numeric replacement_cost
rating rating
timestamp last_update
text special_features
tsvector fulltext
}

FILM_ACTOR {
int actor_id FK
int film_id FK
timestamp last_update
}

FILM_CATEGORY {
int film_id FK
int category_id FK
timestamp last_update
}

INVENTORY {
int inventory_id PK
int film_id FK
int store_id FK
timestamp last_update
}

LANGUAGE {
int language_id PK
varchar name
timestamp last_update
}

PAYMENT {
int payment_id PK
int customer_id FK
int staff_id FK
int rental_id FK
decimal amount
timestamp payment_date
}

RENTAL {
int rental_id PK
datetime rental_date
int inventory_id FK
int customer_id FK
datetime return_date
int staff_id FK
timestamp last_update
}

STAFF {
int staff_id PK
varchar first_name
varchar last_name
int adress_id FK
varchar email
int store_id FK
bool active 
varchar username
varchar password
decimal amount
timestamp last_update
}

STORE {
int store_id PK
int manager_staff_id FK
int adress_id FK
decimal amount
timestamp last_update
}



LANGUAGE ||--o{ FILM : "used in"
FILM ||--o{ FILM_ACTOR : "has"
ACTOR ||--o{ FILM_ACTOR : "acts in"

FILM ||--o{ FILM_CATEGORY : "classified as"
CATEGORY ||--o{ FILM_CATEGORY : "contains"

FILM ||--o{ INVENTORY : "available as"
STORE ||--o{ INVENTORY : "stores"

INVENTORY ||--o{ RENTAL : "rented in"
CUSTOMER ||--o{ RENTAL : "makes"
STAFF ||--o{ RENTAL : "handles"

RENTAL ||--o{ PAYMENT : "generates"
CUSTOMER ||--o{ PAYMENT : "pays"
STAFF ||--o{ PAYMENT : "receives"

CUSTOMER ||--o{ STORE : "belongs to"
STAFF ||--o{ STORE : "manages"
ADDRESS ||--o{ CUSTOMER : "resides at"
ADDRESS ||--o{ STAFF : "works at"
ADDRESS ||--o{ STORE : "located at"
CITY ||--o{ ADDRESS : "contains"
COUNTRY ||--o{ CITY : "contains"