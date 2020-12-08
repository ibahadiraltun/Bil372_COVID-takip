--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1
-- Dumped by pg_dump version 13.1

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
-- Name: hastane; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hastane (
    hastaneno integer NOT NULL,
    plakano integer NOT NULL,
    postakodu integer NOT NULL,
    isim character varying(50) NOT NULL,
    hastasayisi integer NOT NULL,
    doktorsayisi integer NOT NULL,
    olumsayisi integer NOT NULL
);


ALTER TABLE public.hastane OWNER TO postgres;

--
-- Name: il; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.il (
    plakano integer NOT NULL,
    isim character varying(50) NOT NULL,
    hastasayisi integer NOT NULL,
    doktorsayisi integer NOT NULL,
    olusayisi integer NOT NULL
);


ALTER TABLE public.il OWNER TO postgres;

--
-- Name: ilçe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ilçe" (
    plakano integer NOT NULL,
    postakodu integer NOT NULL,
    isim character varying(50) NOT NULL,
    hastasayisi integer NOT NULL,
    doktorsayisi integer NOT NULL,
    olusayisi integer NOT NULL
);


ALTER TABLE public."ilçe" OWNER TO postgres;

--
-- Name: olasıvakalar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."olasıvakalar" (
    tckn character varying(13) NOT NULL,
    ad character varying(50) NOT NULL,
    soyad character varying(50) NOT NULL,
    telno character varying(50) NOT NULL,
    evadresi character varying(200) NOT NULL,
    isadresi character varying(200) NOT NULL,
    testtarihi date NOT NULL,
    testdurumu smallint,
    yas smallint NOT NULL,
    cinsiyet character varying(50) NOT NULL,
    "kronikhastalık" boolean NOT NULL
);


ALTER TABLE public."olasıvakalar" OWNER TO postgres;

--
-- Name: temas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.temas (
    temaslitckn character varying(13) NOT NULL,
    tckn character varying(13) NOT NULL,
    temastarihi date NOT NULL,
    temasyeri character varying(50) NOT NULL,
    temasliisim character varying(50) NOT NULL,
    temaslisoyisim character varying(50) NOT NULL
);


ALTER TABLE public.temas OWNER TO postgres;

--
-- Name: temaslılar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."temaslılar" (
    temaslitckn character varying(13) NOT NULL,
    ad character varying(50) NOT NULL,
    soyad character varying(50) NOT NULL,
    telno character varying(50) NOT NULL,
    evadresi character varying(200) NOT NULL,
    isadresi character varying(200) NOT NULL
);


ALTER TABLE public."temaslılar" OWNER TO postgres;

--
-- Name: users_authenticationid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_authenticationid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 1000
    CACHE 1;


ALTER TABLE public.users_authenticationid_seq OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    authenticationid integer DEFAULT nextval('public.users_authenticationid_seq'::regclass) NOT NULL,
    username character varying(13) NOT NULL,
    password character varying(200) NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: vakalar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vakalar (
    tckn character varying(13) NOT NULL,
    ilaclistesi character varying(50)[]
);


ALTER TABLE public.vakalar OWNER TO postgres;

--
-- Name: çalışanlar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."çalışanlar" (
    tckn character varying(13) NOT NULL,
    password character varying(50) NOT NULL,
    plakano integer NOT NULL,
    hastaneno integer NOT NULL,
    ad character varying(50) NOT NULL,
    soyad character varying(50) NOT NULL,
    telno character varying(50) NOT NULL,
    postakodu integer NOT NULL,
    tur smallint NOT NULL
);


ALTER TABLE public."çalışanlar" OWNER TO postgres;

--
-- Data for Name: hastane; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hastane (hastaneno, plakano, postakodu, isim, hastasayisi, doktorsayisi, olumsayisi) FROM stdin;
1	6	6100	Bilkent Hastanesi	0	0	0
\.


--
-- Data for Name: il; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.il (plakano, isim, hastasayisi, doktorsayisi, olusayisi) FROM stdin;
6	Ankara	0	0	0
\.


--
-- Data for Name: ilçe; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ilçe" (plakano, postakodu, isim, hastasayisi, doktorsayisi, olusayisi) FROM stdin;
6	6100	Çankaya	0	0	0
\.


--
-- Data for Name: olasıvakalar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."olasıvakalar" (tckn, ad, soyad, telno, evadresi, isadresi, testtarihi, testdurumu, yas, cinsiyet, "kronikhastalık") FROM stdin;
\.


--
-- Data for Name: temas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.temas (temaslitckn, tckn, temastarihi, temasyeri, temasliisim, temaslisoyisim) FROM stdin;
\.


--
-- Data for Name: temaslılar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."temaslılar" (temaslitckn, ad, soyad, telno, evadresi, isadresi) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (authenticationid, username, password) FROM stdin;
1	1234567890000	sha256$plMt0g9C$1fded42a29271334c3e9fda1252629e6088fa62a6534cd39de148e157d1a0094
\.


--
-- Data for Name: vakalar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vakalar (tckn, ilaclistesi) FROM stdin;
\.


--
-- Data for Name: çalışanlar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."çalışanlar" (tckn, password, plakano, hastaneno, ad, soyad, telno, postakodu, tur) FROM stdin;
\.


--
-- Name: users_authenticationid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_authenticationid_seq', 1, false);


--
-- Name: hastane hastane_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hastane
    ADD CONSTRAINT hastane_pkey PRIMARY KEY (hastaneno, plakano, postakodu);


--
-- Name: il il_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.il
    ADD CONSTRAINT il_pkey PRIMARY KEY (plakano);


--
-- Name: ilçe ilçe_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ilçe"
    ADD CONSTRAINT "ilçe_pkey" PRIMARY KEY (plakano, postakodu);


--
-- Name: olasıvakalar olasıvakalar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."olasıvakalar"
    ADD CONSTRAINT "olasıvakalar_pkey" PRIMARY KEY (tckn);


--
-- Name: temas temas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.temas
    ADD CONSTRAINT temas_pkey PRIMARY KEY (temaslitckn, tckn);


--
-- Name: temaslılar temaslılar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."temaslılar"
    ADD CONSTRAINT "temaslılar_pkey" PRIMARY KEY (temaslitckn);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (authenticationid);


--
-- Name: vakalar vakalar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vakalar
    ADD CONSTRAINT vakalar_pkey PRIMARY KEY (tckn);


--
-- Name: çalışanlar çalışanlar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."çalışanlar"
    ADD CONSTRAINT "çalışanlar_pkey" PRIMARY KEY (tckn);


--
-- Name: hastane hastane_plakano_postakodu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hastane
    ADD CONSTRAINT hastane_plakano_postakodu_fkey FOREIGN KEY (plakano, postakodu) REFERENCES public."ilçe"(plakano, postakodu) ON DELETE CASCADE NOT VALID;


--
-- Name: ilçe ilçe_plakano_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ilçe"
    ADD CONSTRAINT "ilçe_plakano_fkey" FOREIGN KEY (plakano) REFERENCES public.il(plakano) ON DELETE CASCADE;


--
-- Name: temas temas_tckn_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.temas
    ADD CONSTRAINT temas_tckn_fkey FOREIGN KEY (tckn) REFERENCES public.vakalar(tckn);


--
-- Name: temas temas_temaslitckn_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.temas
    ADD CONSTRAINT temas_temaslitckn_fkey FOREIGN KEY (temaslitckn) REFERENCES public."temaslılar"(temaslitckn) ON DELETE CASCADE;


--
-- Name: vakalar vakalar_tckn_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vakalar
    ADD CONSTRAINT vakalar_tckn_fkey FOREIGN KEY (tckn) REFERENCES public."olasıvakalar"(tckn);


--
-- Name: çalışanlar çalışanlar_hastaneno_postakodu_plakano_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."çalışanlar"
    ADD CONSTRAINT "çalışanlar_hastaneno_postakodu_plakano_fkey" FOREIGN KEY (hastaneno, postakodu, plakano) REFERENCES public.hastane(hastaneno, postakodu, plakano);


--
-- PostgreSQL database dump complete
--

