--
-- PostgreSQL database dump
--

-- Dumped from database version 15.0
-- Dumped by pg_dump version 15.0

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    product_id integer NOT NULL,
    product_name character varying(100),
    price numeric(10,2),
    user_id integer
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_product_id_seq OWNER TO postgres;

--
-- Name: products_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_product_id_seq OWNED BY public.products.product_id;


--
-- Name: sales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sales (
    sale_id integer NOT NULL,
    user_id integer,
    product_id integer,
    sale_date date,
    quantity integer,
    total_price numeric(10,2)
);


ALTER TABLE public.sales OWNER TO postgres;

--
-- Name: sales_sale_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sales_sale_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sales_sale_id_seq OWNER TO postgres;

--
-- Name: sales_sale_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sales_sale_id_seq OWNED BY public.sales.sale_id;


--
-- Name: servers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.servers (
    server_id integer NOT NULL,
    location character varying(50),
    status character varying(20),
    user_id integer
);


ALTER TABLE public.servers OWNER TO postgres;

--
-- Name: servers_server_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.servers_server_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.servers_server_id_seq OWNER TO postgres;

--
-- Name: servers_server_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.servers_server_id_seq OWNED BY public.servers.server_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(100),
    phone_number character varying(15),
    address character varying(255),
    registration_date date
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: products product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);


--
-- Name: sales sale_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales ALTER COLUMN sale_id SET DEFAULT nextval('public.sales_sale_id_seq'::regclass);


--
-- Name: servers server_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servers ALTER COLUMN server_id SET DEFAULT nextval('public.servers_server_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (product_id, product_name, price) FROM stdin;
1	Product 1	49.99
2	Product 2	29.99
3	Product 3	39.99
4	Product 4	19.99
5	Product 5	59.99
6	Product 6	79.99
7	Product 7	24.99
8	Product 8	69.99
9	Product 9	34.99
10	Product 10	44.99
11	Product 11	54.99
12	Product 12	64.99
13	Product 13	74.99
14	Product 14	84.99
15	Product 15	94.99
16	Product 16	104.99
17	Product 17	114.99
18	Product 18	124.99
19	Product 19	134.99
20	Product 20	144.99
\.


--
-- Data for Name: sales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sales (sale_id, user_id, product_id, sale_date, quantity, total_price) FROM stdin;
1	1	1	2023-01-01	5	249.95
2	2	2	2023-01-02	3	89.97
3	3	3	2023-01-03	2	79.98
4	4	4	2023-01-04	7	139.93
5	5	5	2023-01-05	4	239.96
6	6	6	2023-01-06	1	79.99
7	7	7	2023-01-07	6	149.94
8	8	8	2023-01-08	3	209.97
9	9	9	2023-01-09	2	69.98
10	10	10	2023-01-10	8	359.92
11	1	2	2023-01-11	5	149.95
12	2	3	2023-01-12	4	159.96
13	3	4	2023-01-13	2	39.98
14	4	5	2023-01-14	6	179.94
15	5	6	2023-01-15	3	239.97
16	6	7	2023-01-16	4	99.96
17	7	8	2023-01-17	2	69.98
18	8	9	2023-01-18	7	279.93
19	9	10	2023-01-19	1	49.99
20	10	1	2023-01-20	3	149.97
\.


--
-- Data for Name: servers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.servers (server_id, location, status, user_id) FROM stdin;
1	Jakarta	Active	1
2	Bandung	Active	2
3	Surabaya	Inactive	3
4	Yogyakarta	Active	4
5	Semarang	Inactive	5
6	Medan	Active	6
7	Bali	Active	7
8	Makassar	Inactive	8
9	Palembang	Active	9
10	Balikpapan	Active	10
11	Denpasar	Inactive	1
12	Samarinda	Active	2
13	Manado	Active	3
14	Pekanbaru	Inactive	4
15	Pontianak	Active	5
16	Banjarmasin	Active	6
17	Malang	Inactive	7
18	Padang	Active	8
19	Bandar Lampung	Active	9
20	Ambon	Inactive	10
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, first_name, last_name, email, phone_number, address, registration_date) FROM stdin;
1	John	Doe	john.doe@example.com	123-456-7890	123 Main St	\N
2	Jane	Smith	jane.smith@example.com	987-654-3210	456 Elm St	\N
3	Alice	Johnson	alice.johnson@example.com	555-123-4567	789 Oak Ave	\N
4	Bob	Wilson	bob.wilson@example.com	888-555-1234	567 Pine St	\N
5	Eva	Adams	eva.adams@example.com	777-888-9999	321 Birch Rd	\N
6	Mike	Brown	mike.brown@example.com	999-111-7777	654 Maple Ln	\N
7	Sarah	Miller	sarah.miller@example.com	111-222-3333	987 Cedar Ave	\N
8	Daniel	Lee	daniel.lee@example.com	222-333-4444	765 Redwood St	\N
9	Emily	Garcia	emily.garcia@example.com	333-444-5555	543 Magnolia Rd	\N
10	William	Lopez	william.lopez@example.com	444-555-6666	234 Oakwood Ln	\N
11	Olivia	Harris	olivia.harris@example.com	555-666-7777	321 Birch Rd	\N
12	James	Clark	james.clark@example.com	666-777-8888	432 Birch Ave	\N
13	Ava	Young	ava.young@example.com	777-888-9999	987 Elmwood Dr	\N
14	Logan	Perez	logan.perez@example.com	888-999-0000	234 Pine St	\N
15	Mia	Hall	mia.hall@example.com	999-000-1111	543 Redwood Rd	\N
16	Benjamin	Morales	benjamin.morales@example.com	000-111-2222	876 Cedar Ave	\N
17	Emma	Gonzalez	emma.gonzalez@example.com	111-222-3333	765 Oakwood Ln	\N
18	Oliver	King	oliver.king@example.com	222-333-4444	654 Maple Ave	\N
19	Charlotte	Wright	charlotte.wright@example.com	333-444-5555	876 Birch Rd	\N
20	Liam	Torres	liam.torres@example.com	444-555-6666	345 Pine St	\N
\.


--
-- Name: products_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_product_id_seq', 20, true);


--
-- Name: sales_sale_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sales_sale_id_seq', 20, true);


--
-- Name: servers_server_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.servers_server_id_seq', 20, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 20, true);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- Name: sales sales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_pkey PRIMARY KEY (sale_id);


--
-- Name: servers servers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servers
    ADD CONSTRAINT servers_pkey PRIMARY KEY (server_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: products products_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: sales sales_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id);


--
-- Name: sales sales_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: servers servers_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servers
    ADD CONSTRAINT servers_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--

