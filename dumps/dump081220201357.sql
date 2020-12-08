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
-- Name: hastane; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: il; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.il (
    plakano integer NOT NULL,
    isim character varying(50) NOT NULL,
    hastasayisi integer NOT NULL,
    doktorsayisi integer NOT NULL,
    olusayisi integer NOT NULL
);


--
-- Name: ilçe; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."ilçe" (
    plakano integer NOT NULL,
    postakodu integer NOT NULL,
    isim character varying(50) NOT NULL,
    hastasayisi integer NOT NULL,
    doktorsayisi integer NOT NULL,
    olusayisi integer NOT NULL
);


--
-- Name: olasıvakalar; Type: TABLE; Schema: public; Owner: -
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
    kronikhastalik boolean NOT NULL
);


--
-- Name: temas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.temas (
    temaslitckn character varying(13) NOT NULL,
    tckn character varying(13) NOT NULL,
    temastarihi date NOT NULL,
    temasyeri character varying(50) NOT NULL,
    temasliisim character varying(50) NOT NULL,
    temaslisoyisim character varying(50) NOT NULL
);


--
-- Name: temaslılar; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."temaslılar" (
    temaslitckn character varying(13) NOT NULL,
    ad character varying(50) NOT NULL,
    soyad character varying(50) NOT NULL,
    telno character varying(50) NOT NULL,
    evadresi character varying(200) NOT NULL,
    isadresi character varying(200) NOT NULL
);


--
-- Name: users_authenticationid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_authenticationid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 1000
    CACHE 1;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    authenticationid integer DEFAULT nextval('public.users_authenticationid_seq'::regclass) NOT NULL,
    username character varying(13) NOT NULL,
    password character varying(200) NOT NULL
);


--
-- Name: vakalar; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.vakalar (
    tckn character varying(13) NOT NULL,
    ilaclistesi character varying(50)[]
);


--
-- Name: çalışanlar; Type: TABLE; Schema: public; Owner: -
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


--
-- Data for Name: hastane; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.hastane (hastaneno, plakano, postakodu, isim, hastasayisi, doktorsayisi, olumsayisi) FROM stdin;
1	6	6100	Bilkent Hastanesi	0	0	0
\.


--
-- Data for Name: il; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.il (plakano, isim, hastasayisi, doktorsayisi, olusayisi) FROM stdin;
6	Ankara	0	0	0
\.


--
-- Data for Name: ilçe; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."ilçe" (plakano, postakodu, isim, hastasayisi, doktorsayisi, olusayisi) FROM stdin;
6	6100	Çankaya	0	0	0
\.


--
-- Data for Name: olasıvakalar; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."olasıvakalar" (tckn, ad, soyad, telno, evadresi, isadresi, testtarihi, testdurumu, yas, cinsiyet, kronikhastalik) FROM stdin;
5555555555552	ali	baydemir	12315612312	ank	ist	2020-08-12	0	18	E	t
asd	asd	asd	asd	asd	asd	2020-12-02	0	18	E	t
degismis	bahadir	altun	123123123123123	ist	ank	2020-09-12	0	20	F	f
\.


--
-- Data for Name: temas; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.temas (temaslitckn, tckn, temastarihi, temasyeri, temasliisim, temaslisoyisim) FROM stdin;
\.


--
-- Data for Name: temaslılar; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."temaslılar" (temaslitckn, ad, soyad, telno, evadresi, isadresi) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (authenticationid, username, password) FROM stdin;
1	1234567890000	sha256$plMt0g9C$1fded42a29271334c3e9fda1252629e6088fa62a6534cd39de148e157d1a0094
\.


--
-- Data for Name: vakalar; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.vakalar (tckn, ilaclistesi) FROM stdin;
\.


--
-- Data for Name: çalışanlar; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."çalışanlar" (tckn, password, plakano, hastaneno, ad, soyad, telno, postakodu, tur) FROM stdin;
\.


--
-- Name: users_authenticationid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_authenticationid_seq', 1, false);


--
-- Name: hastane hastane_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hastane
    ADD CONSTRAINT hastane_pkey PRIMARY KEY (hastaneno, plakano, postakodu);


--
-- Name: il il_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.il
    ADD CONSTRAINT il_pkey PRIMARY KEY (plakano);


--
-- Name: ilçe ilçe_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."ilçe"
    ADD CONSTRAINT "ilçe_pkey" PRIMARY KEY (plakano, postakodu);


--
-- Name: olasıvakalar olasıvakalar_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."olasıvakalar"
    ADD CONSTRAINT "olasıvakalar_pkey" PRIMARY KEY (tckn);


--
-- Name: temas temas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.temas
    ADD CONSTRAINT temas_pkey PRIMARY KEY (temaslitckn, tckn);


--
-- Name: temaslılar temaslılar_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."temaslılar"
    ADD CONSTRAINT "temaslılar_pkey" PRIMARY KEY (temaslitckn);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (authenticationid);


--
-- Name: vakalar vakalar_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vakalar
    ADD CONSTRAINT vakalar_pkey PRIMARY KEY (tckn);


--
-- Name: çalışanlar çalışanlar_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."çalışanlar"
    ADD CONSTRAINT "çalışanlar_pkey" PRIMARY KEY (tckn);


--
-- Name: hastane hastane_plakano_postakodu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hastane
    ADD CONSTRAINT hastane_plakano_postakodu_fkey FOREIGN KEY (plakano, postakodu) REFERENCES public."ilçe"(plakano, postakodu) ON DELETE CASCADE NOT VALID;


--
-- Name: ilçe ilçe_plakano_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."ilçe"
    ADD CONSTRAINT "ilçe_plakano_fkey" FOREIGN KEY (plakano) REFERENCES public.il(plakano) ON DELETE CASCADE;


--
-- Name: temas temas_tckn_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.temas
    ADD CONSTRAINT temas_tckn_fkey FOREIGN KEY (tckn) REFERENCES public.vakalar(tckn);


--
-- Name: temas temas_temaslitckn_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.temas
    ADD CONSTRAINT temas_temaslitckn_fkey FOREIGN KEY (temaslitckn) REFERENCES public."temaslılar"(temaslitckn) ON DELETE CASCADE;


--
-- Name: vakalar vakalar_tckn_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vakalar
    ADD CONSTRAINT vakalar_tckn_fkey FOREIGN KEY (tckn) REFERENCES public."olasıvakalar"(tckn);


--
-- Name: çalışanlar çalışanlar_hastaneno_postakodu_plakano_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."çalışanlar"
    ADD CONSTRAINT "çalışanlar_hastaneno_postakodu_plakano_fkey" FOREIGN KEY (hastaneno, postakodu, plakano) REFERENCES public.hastane(hastaneno, postakodu, plakano);


--
-- PostgreSQL database dump complete
--

