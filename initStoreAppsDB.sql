SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

CREATE SCHEMA store_apps;


SET default_table_access_method = heap;

/*
CREATE TABLE store_apps.mhealthatlas_app (
    app_id integer NOT NULL PRIMARY KEY,
    android_app_id integer,
    ios_app_id integer,
    private_customer_app_id integer
);

ALTER TABLE store_apps.mhealthatlas_app ALTER COLUMN app_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME store_apps.mhealthatlas_app_app_id_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1
);
*/


CREATE TABLE store_apps.android_app (
    app_id integer NOT NULL PRIMARY KEY,--wird beim inserten generiert
    playstore_id text NOT NULL UNIQUE,
    title text NOT NULL,
    description text NOT NULL,
    icon_url text,
    developer text,
    price_in_cent integer
    --mhealthatlas_app_id integer NOT NULL UNIQUE
);


ALTER TABLE store_apps.android_app ALTER COLUMN app_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME store_apps.android_app_app_id_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1
);
/*
ALTER TABLE ONLY store_apps.android_app
    ADD CONSTRAINT android_app_mhealthatlas_app_id_fkey FOREIGN KEY (mhealthatlas_app_id) REFERENCES store_apps.mhealthatlas_app(app_id) ON DELETE CASCADE ON UPDATE CASCADE;
*/

CREATE TABLE store_apps.android_app_version (
    app_version_id integer NOT NULL PRIMARY KEY,--wird beim inserten generiert
    version text NOT NULL,
    --score text,
    review_count integer,
    release_date timestamp without time zone,
    recent_changes text,
    --last_access timestamp without time zone,
    is_latest_version boolean NOT NULL,
    android_app_id integer NOT NULL,
    -- total_score double precision DEFAULT 0 NOT NULL,
    -- content_score double precision DEFAULT 0 NOT NULL,
    -- usability_score double precision DEFAULT 0 NOT NULL,
    -- security_score double precision DEFAULT 0 NOT NULL,
    -- law_score double precision DEFAULT 0 NOT NULL,
    UNIQUE (android_app_id, version)
);

ALTER TABLE store_apps.android_app_version ALTER COLUMN app_version_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME store_apps.android_app_version_app_version_id_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY store_apps.android_app_version
    ADD CONSTRAINT android_app_version_android_app_id_fkey FOREIGN KEY (android_app_id) REFERENCES store_apps.android_app(app_id) ON DELETE CASCADE ON UPDATE CASCADE;

CREATE INDEX android_app_version_newest_id
  ON store_apps.android_app_version (android_app_id, is_latest_version);


CREATE TABLE store_apps.ios_app (
    app_id integer NOT NULL PRIMARY KEY,
    appstore_id text NOT NULL UNIQUE,
    title text NOT NULL,
    description text NOT NULL,
    icon_url text,
    developer text,
    price_in_cent integer
   -- mhealthatlas_app_id integer NOT NULL UNIQUE
);


ALTER TABLE store_apps.ios_app ALTER COLUMN app_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME store_apps.ios_app_app_id_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1
);
/*
ALTER TABLE ONLY store_apps.ios_app
    ADD CONSTRAINT ios_app_mhealthatlas_app_id_fkey FOREIGN KEY (mhealthatlas_app_id) REFERENCES store_apps.mhealthatlas_app(app_id) ON DELETE CASCADE ON UPDATE CASCADE;
*/

CREATE TABLE store_apps.ios_app_version (
    app_version_id integer NOT NULL PRIMARY KEY,
    version text NOT NULL,
    --score text,
    review_count integer,
    release_date timestamp without time zone,
    recent_changes text,
    --last_access timestamp without time zone,
    is_latest_version boolean NOT NULL,
    ios_app_id integer NOT NULL,
    -- total_score double precision DEFAULT 0 NOT NULL,
    -- content_score double precision DEFAULT 0 NOT NULL,
    -- usability_score double precision DEFAULT 0 NOT NULL,
    -- security_score double precision DEFAULT 0 NOT NULL,
    -- law_score double precision DEFAULT 0 NOT NULL,
    UNIQUE (ios_app_id, version)
);

ALTER TABLE store_apps.ios_app_version ALTER COLUMN app_version_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME store_apps.ios_app_version_app_version_id_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY store_apps.ios_app_version
    ADD CONSTRAINT ios_app_version_ios_app_id_fkey FOREIGN KEY (ios_app_id) REFERENCES store_apps.ios_app(app_id) ON DELETE CASCADE ON UPDATE CASCADE;

CREATE INDEX ios_app_version_newest_id
  ON store_apps.ios_app_version (ios_app_id, is_latest_version);


CREATE TABLE store_apps.private_customer_app (
    app_id integer NOT NULL PRIMARY KEY,
    app_source_url text NOT NULL UNIQUE,
    title text NOT NULL,
    description text NOT NULL,
    icon_url text,
    developer text
   -- mhealthatlas_app_id integer NOT NULL UNIQUE
);

ALTER TABLE store_apps.private_customer_app ALTER COLUMN app_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME store_apps.private_customer_app_app_id_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1
);
/*
ALTER TABLE ONLY store_apps.private_customer_app
    ADD CONSTRAINT private_customer_app_mhealthatlas_app_id_fkey FOREIGN KEY (mhealthatlas_app_id) REFERENCES store_apps.mhealthatlas_app(app_id) ON DELETE CASCADE ON UPDATE CASCADE;
*/

CREATE TABLE store_apps.private_customer_app_version (
    app_version_id integer NOT NULL PRIMARY KEY,
    version text NOT NULL,
    release_date timestamp without time zone,
    recent_changes text,
    --last_access timestamp without time zone,
    is_latest_version boolean NOT NULL,
    private_customer_app_id integer NOT NULL,
    -- total_score double precision DEFAULT 0 NOT NULL,
    -- content_score double precision DEFAULT 0 NOT NULL,
    -- usability_score double precision DEFAULT 0 NOT NULL,
    -- security_score double precision DEFAULT 0 NOT NULL,
    -- law_score double precision DEFAULT 0 NOT NULL,
    UNIQUE (private_customer_app_id, version)
);

ALTER TABLE store_apps.private_customer_app_version ALTER COLUMN app_version_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME store_apps.private_customer_app_version_app_version_id_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY store_apps.private_customer_app_version
    ADD CONSTRAINT private_customer_app_version_private_customer_app_id_fkey FOREIGN KEY (private_customer_app_id) REFERENCES store_apps.private_customer_app(app_id) ON DELETE CASCADE ON UPDATE CASCADE;

CREATE INDEX private_customer_app_version_newest_id
  ON store_apps.private_customer_app_version (private_customer_app_id, is_latest_version);





CREATE TABLE store_apps.outbox (
    event_id UUID NOT NULL PRIMARY KEY,
    version integer NOT NULL,
    root_aggregate_type text NOT NULL,
    root_aggregate_id text NOT NULL,
    aggregate_type text NOT NULL,
    aggregate_id text NOT NULL,
    event_type text NOT NULL,
    payload text NOT NULL
);

ALTER TABLE store_apps.outbox OWNER TO postgres;


INSERT INTO store_apps.android_app (app_id, playstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (0, 'g_p_id_1', 'a app 1', 'My super first Android app description :D', 'https://images.pexels.com/photos/1440722/pexels-photo-1440722.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'healthatlas', 99);
INSERT INTO store_apps.android_app (app_id, playstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (1, 'g_p_id_2', 'a app 2', 'second Android app description, not so bad...a very long text', 'https://images.pexels.com/photos/1181244/pexels-photo-1181244.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'healthatlas', NULL);
INSERT INTO store_apps.android_app (app_id, playstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (2, 'g_p_id_3', 'a app 3', 'short description android', 'https://images.pexels.com/photos/1440727/pexels-photo-1440727.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'healthatlas', NULL);
INSERT INTO store_apps.android_app (app_id, playstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (3, 'g_p_id_4', 'android no ios', 'ANDROID: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/50614/pexels-photo-50614.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'healthatlas', 356);
INSERT INTO store_apps.android_app (app_id, playstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (4, 'duplicate: g_p_id_1', 'duplicate: a app 1', 'duplicate: My super first Android app description :D', 'https://images.pexels.com/photos/1440722/pexels-photo-1440722.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'healthatlas', 99);
INSERT INTO store_apps.android_app (app_id, playstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (5, 'duplicate: g_p_id_2', 'duplicate: a app 2', 'duplicate: second Android app description, not so bad...a very long text', 'https://images.pexels.com/photos/1181244/pexels-photo-1181244.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'healthatlas', NULL);
INSERT INTO store_apps.android_app (app_id, playstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (6, 'duplicate: g_p_id_3', 'duplicate: a app 3', 'duplicate: short description android', 'https://images.pexels.com/photos/1440727/pexels-photo-1440727.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'healthatlas', NULL);
INSERT INTO store_apps.android_app (app_id, playstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (7, 'duplicate: g_p_id_4', 'duplicate: android no ios', 'duplicate: ANDROID: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/50614/pexels-photo-50614.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'healthatlas', 356);
INSERT INTO store_apps.android_app (app_id, playstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (8, 'duplicate 2: g_p_id_4', 'duplicate 2: android no ios', 'duplicate 2: ANDROID: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/50614/pexels-photo-50614.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'healthatlas', 356);
INSERT INTO store_apps.android_app (app_id, playstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (9, 'duplicate 3: g_p_id_4', 'duplicate 3: android no ios', 'duplicate 3: ANDROID: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/50614/pexels-photo-50614.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'healthatlas', 356);
INSERT INTO store_apps.android_app (app_id, playstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (10, 'duplicate 4: g_p_id_4', 'duplicate 4: android no ios', 'duplicate 4: ANDROID: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/50614/pexels-photo-50614.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'healthatlas', 356);
INSERT INTO store_apps.android_app (app_id, playstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (11, 'duplicate 5: g_p_id_4', 'duplicate 5: android no ios', 'duplicate 5: ANDROID: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/50614/pexels-photo-50614.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'healthatlas', 356);
INSERT INTO store_apps.android_app (app_id, playstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (12, 'duplicate 6: g_p_id_4', 'duplicate 6: android no ios', 'duplicate 6: ANDROID: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/50614/pexels-photo-50614.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'healthatlas', 356);
INSERT INTO store_apps.android_app (app_id, playstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (13, 'duplicate 7: g_p_id_4', 'duplicate 7: android no ios', 'duplicate 7: ANDROID: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/50614/pexels-photo-50614.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'healthatlas', 356);
INSERT INTO store_apps.android_app (app_id, playstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (14, 'duplicate 8: g_p_id_4', 'duplicate 8: android no ios', 'duplicate 8: ANDROID: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/50614/pexels-photo-50614.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'healthatlas', 356);
INSERT INTO store_apps.android_app (app_id, playstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (15, 'duplicate 9: g_p_id_4', 'duplicate 9: android no ios', 'duplicate 9: ANDROID: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/50614/pexels-photo-50614.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'healthatlas', 356);
INSERT INTO store_apps.android_app (app_id, playstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (16, 'duplicate 10: g_p_id_4', 'duplicate 10: android no ios', 'duplicate 10: ANDROID: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/50614/pexels-photo-50614.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'healthatlas', 356);
INSERT INTO store_apps.android_app (app_id, playstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (17, 'duplicate 11: g_p_id_4', 'duplicate 11: android no ios', 'duplicate 11: ANDROID: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/50614/pexels-photo-50614.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'healthatlas', 356);
INSERT INTO store_apps.android_app (app_id, playstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (18, 'duplicate 12: g_p_id_4', 'duplicate 12: android no ios', 'duplicate 12: ANDROID: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/50614/pexels-photo-50614.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'healthatlas', 356);
INSERT INTO store_apps.android_app (app_id, playstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (19, 'duplicate 13: g_p_id_4', 'duplicate 13: android no ios', 'duplicate 13: ANDROID: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/50614/pexels-photo-50614.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'healthatlas', 356);
INSERT INTO store_apps.android_app (app_id, playstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (20, 'duplicate 14: g_p_id_4', 'duplicate 14: android no ios', 'duplicate 14: ANDROID: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/50614/pexels-photo-50614.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'healthatlas', 356);
INSERT INTO store_apps.android_app (app_id, playstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (21, 'duplicate 15: g_p_id_4', 'duplicate 15: android no ios', 'duplicate 15: ANDROID: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/50614/pexels-photo-50614.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'healthatlas', 356);
INSERT INTO store_apps.android_app (app_id, playstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (22, 'duplicate 16: g_p_id_4', 'duplicate 16: android no ios', 'duplicate 16: ANDROID: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/50614/pexels-photo-50614.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'healthatlas', 356);
INSERT INTO store_apps.android_app (app_id, playstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (23, 'duplicate 17: g_p_id_4', 'duplicate 17: android no ios', 'duplicate 17: ANDROID: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/50614/pexels-photo-50614.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'healthatlas', 356);

INSERT INTO store_apps.ios_app (app_id, appstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (0, 'g_a_id_1', 'appstore app 1', 'My super first Ios app description :D', 'https://images.pexels.com/photos/1440722/pexels-photo-1440722.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'developer', NULL);
INSERT INTO store_apps.ios_app (app_id, appstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (1, 'g_a_id_2', 'appstore app 2', 'second Ios app description, not so bad...a very long text', 'https://images.pexels.com/photos/1181244/pexels-photo-1181244.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'developer', 245);
INSERT INTO store_apps.ios_app (app_id, appstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (2, 'g_a_id_3', 'appstore app 3', 'short description ios', 'https://images.pexels.com/photos/1440727/pexels-photo-1440727.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'developer', NULL);
INSERT INTO store_apps.ios_app (app_id, appstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (3, 'g_a_id_4', 'ios no android', 'IOS: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/38544/imac-apple-mockup-app-38544.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'developer', 1000);
INSERT INTO store_apps.ios_app (app_id, appstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (4, 'duplicate: g_a_id_1', 'duplicate: appstore app 1', 'duplicate: My super first Ios app description :D', 'https://images.pexels.com/photos/1440722/pexels-photo-1440722.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'developer', NULL);
INSERT INTO store_apps.ios_app (app_id, appstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (5, 'duplicate: g_a_id_2', 'duplicate: appstore app 2', 'duplicate: second Ios app description, not so bad...a very long text', 'https://images.pexels.com/photos/1181244/pexels-photo-1181244.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'developer', 245);
INSERT INTO store_apps.ios_app (app_id, appstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (6, 'duplicate: g_a_id_3', 'duplicate: appstore app 3', 'duplicate: short description ios', 'https://images.pexels.com/photos/1440727/pexels-photo-1440727.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'developer', NULL);
INSERT INTO store_apps.ios_app (app_id, appstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (7, 'duplicate: g_a_id_4', 'duplicate: ios no android', 'duplicate: IOS: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/38544/imac-apple-mockup-app-38544.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'developer', 1000);
INSERT INTO store_apps.ios_app (app_id, appstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (8, 'duplicate 2: g_a_id_4', 'duplicate 2: ios no android', 'duplicate 2: IOS: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/38544/imac-apple-mockup-app-38544.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'developer', 1000);
INSERT INTO store_apps.ios_app (app_id, appstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (9, 'duplicate 3: g_a_id_4', 'duplicate 3: ios no android', 'duplicate 3: IOS: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/38544/imac-apple-mockup-app-38544.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'developer', 1000);
INSERT INTO store_apps.ios_app (app_id, appstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (10, 'duplicate 4: g_a_id_4', 'duplicate 4: ios no android', 'duplicate 4: IOS: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/38544/imac-apple-mockup-app-38544.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'developer', 1000);
INSERT INTO store_apps.ios_app (app_id, appstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (11, 'duplicate 5: g_a_id_4', 'duplicate 5: ios no android', 'duplicate 5: IOS: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/38544/imac-apple-mockup-app-38544.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'developer', 1000);
INSERT INTO store_apps.ios_app (app_id, appstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (12, 'duplicate 6: g_a_id_4', 'duplicate 6: ios no android', 'duplicate 6: IOS: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/38544/imac-apple-mockup-app-38544.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'developer', 1000);
INSERT INTO store_apps.ios_app (app_id, appstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (13, 'duplicate 7: g_a_id_4', 'duplicate 7: ios no android', 'duplicate 7: IOS: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/38544/imac-apple-mockup-app-38544.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'developer', 1000);
INSERT INTO store_apps.ios_app (app_id, appstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (14, 'duplicate 8: g_a_id_4', 'duplicate 8: ios no android', 'duplicate 8: IOS: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/38544/imac-apple-mockup-app-38544.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'developer', 1000);
INSERT INTO store_apps.ios_app (app_id, appstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (15, 'duplicate 9: g_a_id_4', 'duplicate 9: ios no android', 'duplicate 9: IOS: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/38544/imac-apple-mockup-app-38544.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'developer', 1000);
INSERT INTO store_apps.ios_app (app_id, appstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (16, 'duplicate 10: g_a_id_4', 'duplicate 10: ios no android', 'duplicate 10: IOS: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/38544/imac-apple-mockup-app-38544.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'developer', 1000);
INSERT INTO store_apps.ios_app (app_id, appstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (17, 'duplicate 11: g_a_id_4', 'duplicate 11: ios no android', 'duplicate 11: IOS: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/38544/imac-apple-mockup-app-38544.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'developer', 1000);
INSERT INTO store_apps.ios_app (app_id, appstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (18, 'duplicate 12: g_a_id_4', 'duplicate 12: ios no android', 'duplicate 12: IOS: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/38544/imac-apple-mockup-app-38544.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'developer', 1000);
INSERT INTO store_apps.ios_app (app_id, appstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (19, 'duplicate 13: g_a_id_4', 'duplicate 13: ios no android', 'duplicate 13: IOS: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/38544/imac-apple-mockup-app-38544.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'developer', 1000);
INSERT INTO store_apps.ios_app (app_id, appstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (20, 'duplicate 14: g_a_id_4', 'duplicate 14: ios no android', 'duplicate 14: IOS: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/38544/imac-apple-mockup-app-38544.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'developer', 1000);
INSERT INTO store_apps.ios_app (app_id, appstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (21, 'duplicate 15: g_a_id_4', 'duplicate 15: ios no android', 'duplicate 15: IOS: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/38544/imac-apple-mockup-app-38544.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'developer', 1000);
INSERT INTO store_apps.ios_app (app_id, appstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (22, 'duplicate 16: g_a_id_4', 'duplicate 16: ios no android', 'duplicate 16: IOS: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/38544/imac-apple-mockup-app-38544.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'developer', 1000);
INSERT INTO store_apps.ios_app (app_id, appstore_id, title, description, icon_url, developer, price_in_cent) OVERRIDING SYSTEM VALUE VALUES (23, 'duplicate 17: g_a_id_4', 'duplicate 17: ios no android', 'duplicate 17: IOS: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', 'https://images.pexels.com/photos/38544/imac-apple-mockup-app-38544.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'developer', 1000);

INSERT INTO store_apps.private_customer_app (app_id, app_source_url, title, description, icon_url, developer) OVERRIDING SYSTEM VALUE VALUES (0, 'test url', 'private customer app 1', 'My super first private customer app description :D', 'https://images.pexels.com/photos/1440722/pexels-photo-1440722.jpeg?auto=compress&cs=tinysrgb&dpr=1&h=200', 'developer');

INSERT INTO store_apps.android_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, android_app_id) OVERRIDING SYSTEM VALUE VALUES (0, '1.0', 3, '2020-07-07 09:39:27', 'first release', false, 0);
INSERT INTO store_apps.android_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, android_app_id) OVERRIDING SYSTEM VALUE VALUES (1, '2.0', 16, '2020-07-07 09:49:27', 'bad change', true, 0);
INSERT INTO store_apps.android_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, android_app_id) OVERRIDING SYSTEM VALUE VALUES (2, '1.0', 16, '2020-07-07 09:49:27', 'first release', true, 1);
INSERT INTO store_apps.android_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, android_app_id) OVERRIDING SYSTEM VALUE VALUES (3, '1.0', 16, '2020-07-07 09:49:27', 'first release x_d', false, 2);
INSERT INTO store_apps.android_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, android_app_id) OVERRIDING SYSTEM VALUE VALUES (4, '2.0', 100, '2020-06-07 09:49:27', 'good change', true, 2);
INSERT INTO store_apps.android_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, android_app_id) OVERRIDING SYSTEM VALUE VALUES (5, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 3);
INSERT INTO store_apps.android_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, android_app_id) OVERRIDING SYSTEM VALUE VALUES (6, '1.0', 3, '2020-07-07 09:39:27', 'first release', false, 4);
INSERT INTO store_apps.android_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, android_app_id) OVERRIDING SYSTEM VALUE VALUES (7, '2.0', 16, '2020-07-07 09:49:27', 'bad change', true, 4);
INSERT INTO store_apps.android_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, android_app_id) OVERRIDING SYSTEM VALUE VALUES (8, '1.0', 16, '2020-07-07 09:49:27', 'first release', true, 5);
INSERT INTO store_apps.android_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, android_app_id) OVERRIDING SYSTEM VALUE VALUES (9, '1.0', 16, '2020-07-07 09:49:27', 'first release x_d', false, 6);
INSERT INTO store_apps.android_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, android_app_id) OVERRIDING SYSTEM VALUE VALUES (10, '2.0', 100, '2020-06-07 09:49:27', 'good change', true, 6);
INSERT INTO store_apps.android_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, android_app_id) OVERRIDING SYSTEM VALUE VALUES (11, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 7);
INSERT INTO store_apps.android_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, android_app_id) OVERRIDING SYSTEM VALUE VALUES (12, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 8);
INSERT INTO store_apps.android_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, android_app_id) OVERRIDING SYSTEM VALUE VALUES (13, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 9);
INSERT INTO store_apps.android_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, android_app_id) OVERRIDING SYSTEM VALUE VALUES (14, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 10);
INSERT INTO store_apps.android_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, android_app_id) OVERRIDING SYSTEM VALUE VALUES (15, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 11);
INSERT INTO store_apps.android_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, android_app_id) OVERRIDING SYSTEM VALUE VALUES (16, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 12);
INSERT INTO store_apps.android_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, android_app_id) OVERRIDING SYSTEM VALUE VALUES (17, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 13);
INSERT INTO store_apps.android_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, android_app_id) OVERRIDING SYSTEM VALUE VALUES (18, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 14);
INSERT INTO store_apps.android_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, android_app_id) OVERRIDING SYSTEM VALUE VALUES (19, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 15);
INSERT INTO store_apps.android_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, android_app_id) OVERRIDING SYSTEM VALUE VALUES (20, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 16);
INSERT INTO store_apps.android_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, android_app_id) OVERRIDING SYSTEM VALUE VALUES (21, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 17);
INSERT INTO store_apps.android_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, android_app_id) OVERRIDING SYSTEM VALUE VALUES (22, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 18);
INSERT INTO store_apps.android_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, android_app_id) OVERRIDING SYSTEM VALUE VALUES (23, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 19);
INSERT INTO store_apps.android_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, android_app_id) OVERRIDING SYSTEM VALUE VALUES (24, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 20);
INSERT INTO store_apps.android_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, android_app_id) OVERRIDING SYSTEM VALUE VALUES (25, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 21);
INSERT INTO store_apps.android_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, android_app_id) OVERRIDING SYSTEM VALUE VALUES (26, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 22);
INSERT INTO store_apps.android_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, android_app_id) OVERRIDING SYSTEM VALUE VALUES (27, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 23);

INSERT INTO store_apps.ios_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, ios_app_id) OVERRIDING SYSTEM VALUE VALUES (0, '1.0', 2, '2020-07-07 09:39:27', 'first ios release', false, 0);
INSERT INTO store_apps.ios_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, ios_app_id) OVERRIDING SYSTEM VALUE VALUES (1, '2.0', 56, '2020-07-07 10:39:27', 'make ios great again', true, 0);
INSERT INTO store_apps.ios_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, ios_app_id) OVERRIDING SYSTEM VALUE VALUES (2, '1.0', 54, '2020-07-06 09:39:27', 'release party', false, 1);
INSERT INTO store_apps.ios_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, ios_app_id) OVERRIDING SYSTEM VALUE VALUES (3, '2.0', 2, '2020-07-08 09:39:27', 'buf fixes', true, 1);
INSERT INTO store_apps.ios_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, ios_app_id) OVERRIDING SYSTEM VALUE VALUES (4, '1.0', 32, '2020-07-07 09:39:27', 'ios auto generated app', true, 2);
INSERT INTO store_apps.ios_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, ios_app_id) OVERRIDING SYSTEM VALUE VALUES (5, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 3);
INSERT INTO store_apps.ios_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, ios_app_id) OVERRIDING SYSTEM VALUE VALUES (6, '1.0', 2, '2020-07-07 09:39:27', 'first ios release', false, 4);
INSERT INTO store_apps.ios_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, ios_app_id) OVERRIDING SYSTEM VALUE VALUES (7, '2.0', 56, '2020-07-07 10:39:27', 'make ios great again', true, 4);
INSERT INTO store_apps.ios_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, ios_app_id) OVERRIDING SYSTEM VALUE VALUES (8, '1.0', 54, '2020-07-06 09:39:27', 'release party', false, 5);
INSERT INTO store_apps.ios_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, ios_app_id) OVERRIDING SYSTEM VALUE VALUES (9, '2.0', 2, '2020-07-08 09:39:27', 'buf fixes', true, 5);
INSERT INTO store_apps.ios_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, ios_app_id) OVERRIDING SYSTEM VALUE VALUES (10, '1.0', 32, '2020-07-07 09:39:27', 'ios auto generated app', true, 6);
INSERT INTO store_apps.ios_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, ios_app_id) OVERRIDING SYSTEM VALUE VALUES (11, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 7);
INSERT INTO store_apps.ios_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, ios_app_id) OVERRIDING SYSTEM VALUE VALUES (12, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 8);
INSERT INTO store_apps.ios_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, ios_app_id) OVERRIDING SYSTEM VALUE VALUES (13, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 9);
INSERT INTO store_apps.ios_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, ios_app_id) OVERRIDING SYSTEM VALUE VALUES (14, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 10);
INSERT INTO store_apps.ios_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, ios_app_id) OVERRIDING SYSTEM VALUE VALUES (15, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 11);
INSERT INTO store_apps.ios_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, ios_app_id) OVERRIDING SYSTEM VALUE VALUES (16, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 12);
INSERT INTO store_apps.ios_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, ios_app_id) OVERRIDING SYSTEM VALUE VALUES (17, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 13);
INSERT INTO store_apps.ios_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, ios_app_id) OVERRIDING SYSTEM VALUE VALUES (18, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 14);
INSERT INTO store_apps.ios_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, ios_app_id) OVERRIDING SYSTEM VALUE VALUES (19, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 15);
INSERT INTO store_apps.ios_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, ios_app_id) OVERRIDING SYSTEM VALUE VALUES (20, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 16);
INSERT INTO store_apps.ios_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, ios_app_id) OVERRIDING SYSTEM VALUE VALUES (21, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 17);
INSERT INTO store_apps.ios_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, ios_app_id) OVERRIDING SYSTEM VALUE VALUES (22, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 18);
INSERT INTO store_apps.ios_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, ios_app_id) OVERRIDING SYSTEM VALUE VALUES (23, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 19);
INSERT INTO store_apps.ios_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, ios_app_id) OVERRIDING SYSTEM VALUE VALUES (24, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 20);
INSERT INTO store_apps.ios_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, ios_app_id) OVERRIDING SYSTEM VALUE VALUES (25, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 21);
INSERT INTO store_apps.ios_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, ios_app_id) OVERRIDING SYSTEM VALUE VALUES (26, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 22);
INSERT INTO store_apps.ios_app_version (app_version_id, version,  review_count, release_date, recent_changes,  is_latest_version, ios_app_id) OVERRIDING SYSTEM VALUE VALUES (27, '1.0', 23, '2020-07-07 09:39:27', 'test app', true, 23);

INSERT INTO store_apps.private_customer_app_version (app_version_id, version, release_date, recent_changes, is_latest_version, private_customer_app_id) OVERRIDING SYSTEM VALUE VALUES (0, '0.1', '2020-07-07 09:39:27', 'first test release', true, 0);

SELECT pg_catalog.setval('store_apps.android_app_app_id_seq', 23, true);
SELECT pg_catalog.setval('store_apps.android_app_version_app_version_id_seq', 27, true);
SELECT pg_catalog.setval('store_apps.ios_app_app_id_seq', 23, true);
SELECT pg_catalog.setval('store_apps.ios_app_version_app_version_id_seq', 27, true);
SELECT pg_catalog.setval('store_apps.private_customer_app_app_id_seq', 1, true);
SELECT pg_catalog.setval('store_apps.private_customer_app_version_app_version_id_seq', 1, true);
--SELECT pg_catalog.setval('store_apps.mhealthatlas_app_app_id_seq', 42, true);
-- SELECT pg_catalog.setval('store_apps.app_version_category_id_seq', 40, true);
