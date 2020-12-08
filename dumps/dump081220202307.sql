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
    kronikhastalik boolean NOT NULL
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
    ilaclistesi character varying(50)[],
    durum integer NOT NULL
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
1	6	6100	Bilkent Hastanesi	0	1	0
2	6	6300	Ankara Atatürk Eğitim ve Araştırma Hastanesi	0	0	0
3	6	6080	Ankara Eğitim ve Araştırma Hastanesi	0	0	0
4	6	6100	Ankara Şehir Hastanesi	0	0	0
5	6	6080	Yıldırım Beyazıt Eğitim Ve Araştırma Hastanesi	0	0	0
6	6	6300	Gülhane Eğitim ve Araştırma Hastanesi	0	0	0
7	6	6300	Sağlık Bilimleri Üni. Eğitim Araştırma Hastanesi	0	0	0
8	6	6560	Yıldırım Beyazıt Eğitim ve Araştırma Hastanesi	0	0	0
9	6	6100	29 Mayıs Devlet Hastanesi	0	0	0
10	6	6750	Ankara Akyurt Devlet Hastanesi	0	0	0
11	6	6830	Ankara Gölbaşı Şehit Ahmet Özsoy Devlet Hastanesi	0	0	0
12	6	6726	Bala İlçe Entegre Devlet Hastanesi	0	0	0
13	6	6730	Beypazarı Devlet Hastanesi	0	0	0
14	6	6100	Beytepe Murat Erdi Eker Devlet Hastanesi	0	0	0
15	6	6780	Dr. Hulusi Alataş Elmadağ Devlet Hastanesi	0	0	0
16	6	6935	Dr. Nafiz Körez Sincan Devlet Hastanesi	0	0	0
17	6	6794	Etimesgut Şehit Sait Ertürk Devlet Hastanesi	0	0	0
18	6	6560	Gazi Mustafa Kemal Devlet Hastanesi	0	0	0
19	6	6842	Güdül İlçe Entegre Devlet Hastanesi	0	0	0
20	6	6760	Halil Şıvgın Çubuk Devlet Hastanesi	0	0	0
21	6	6860	Haymana Devlet Hastanesi	0	0	0
22	6	6980	Kahramankazan Devlet Hastanesi	0	0	0
23	6	6870	Kalecik İlçe Entegre Devlet Hastanesi	0	0	0
24	6	6890	Kızılcahamam Devlet Hastanesi	0	0	0
25	6	6922	Nallıhan Devlet Hastanesi	0	0	0
26	6	6900	Polatlı Duatepe Devlet Hastanesi	0	0	0
27	6	6950	Şereflikoçhisar Devlet Hastanesi	0	0	0
28	6	6100	Ankara Üni. Tıp Fakültesi Cebeci Hastanesi	0	0	0
29	6	6100	Ankara Üni. Tıp Fakültesi İbni Sina Hastanesi	0	0	0
30	6	6100	Başkent Üniversitesi Ankara Hastanesi	0	0	0
31	6	6560	Gazi Üniversitesi Tıp Fakültesi Gazi Hastanesi	0	0	0
32	6	6100	Hacettepe Üniversitesi Beytepe Gün Hastanesi	0	0	0
33	6	6100	Hacettepe Üniversitesi Erişkin Hastanesi	0	0	0
34	6	6100	Ufuk Üniversitesi Dr. Rıdvan Ege Hastanesi	0	0	0
35	6	6794	A Life Hospital	0	0	0
36	6	6100	Acıbadem Hastanesi	0	0	0
37	6	6100	Akay Hastanesi	0	0	0
38	6	6080	Akropol Hastanesi	0	0	0
39	6	6100	Bayındır Hastanesi	0	0	0
40	6	6560	Bilgi Hastanesi	0	0	0
41	6	6100	Çankaya Hastanesi	0	0	0
42	6	6794	Eryaman Hastanesi	0	0	0
43	6	6794	Etimed Hastanesi	0	0	0
44	6	6100	Güven Hastanesi	0	0	0
45	6	6300	Keçiören Hastanesi	0	0	0
46	6	6100	Koru Hastanesi	0	0	0
47	6	6100	Liv Hospital	0	0	0
48	6	6560	Medical Park	0	0	0
49	6	6100	Medicana International Hastanesi	0	0	0
50	6	6100	Magnet Hastanesi	0	0	0
51	6	6100	Medisun Hastanesi	0	0	0
52	6	6100	Memorial Hastanesi	0	0	0
53	6	6100	Mim Hastanesi	0	0	0
54	6	6620	Natomed Hastanesi	0	0	0
55	6	6560	Ortadoğu Hastanesi	0	0	0
56	6	6100	TOBB ETÜ Hastanesi	0	0	0
57	6	6100	Umut Hastanesi	0	0	0
58	6	6100	Yüzüncüyıl Hastanesi	0	0	0
59	6	6100	19 Mayıs Hastanesi	0	0	0
60	6	6145	Ankara Pursaklar Devlet Hastanesi	0	0	0
\.


--
-- Data for Name: il; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.il (plakano, isim, hastasayisi, doktorsayisi, olusayisi) FROM stdin;
1	Adana	0	0	0
2	Adıyaman	0	0	0
3	Afyonkarahisar	0	0	0
4	Ağrı	0	0	0
5	Amasya	0	0	0
7	Antalya	0	0	0
8	Artvin	0	0	0
9	Aydın	0	0	0
10	Balıkesir	0	0	0
11	Bilecik	0	0	0
12	Bingöl	0	0	0
13	Bitlis	0	0	0
14	Bolu	0	0	0
15	Burdur	0	0	0
16	Bursa	0	0	0
17	Çanakkale	0	0	0
18	Çankırı	0	0	0
19	Çorum	0	0	0
20	Denizli	0	0	0
21	Diyarbakır	0	0	0
22	Edirne	0	0	0
23	Elazığ	0	0	0
24	Erzincan	0	0	0
25	Erzurum	0	0	0
26	Eskişehir	0	0	0
27	Gaziantep	0	0	0
28	Giresun	0	0	0
29	Gümüşhane	0	0	0
30	Hakkari	0	0	0
31	Hatay	0	0	0
32	Isparta	0	0	0
33	Mersin	0	0	0
34	İstanbul	0	0	0
35	İzmir	0	0	0
36	Kars	0	0	0
37	Kastamonu	0	0	0
38	Kayseri	0	0	0
39	Kırklareli	0	0	0
40	Kırşehir	0	0	0
41	Kocaeli	0	0	0
42	Konya	0	0	0
43	Kütahya	0	0	0
44	Malatya	0	0	0
45	Manisa	0	0	0
46	Kahramanmaraş	0	0	0
47	Mardin	0	0	0
48	Muğla	0	0	0
49	Muş	0	0	0
50	Nevşehir	0	0	0
51	Niğde	0	0	0
52	Ordu	0	0	0
53	Rize	0	0	0
54	Sakarya	0	0	0
55	Samsun	0	0	0
56	Siirt	0	0	0
57	Sinop	0	0	0
58	Sivas	0	0	0
59	Tekirdağ	0	0	0
60	Tokat	0	0	0
61	Trabzon	0	0	0
62	Tunceli	0	0	0
63	Şanlıurfa	0	0	0
64	Uşak	0	0	0
65	Van	0	0	0
66	Yozgat	0	0	0
67	Zonguldak	0	0	0
68	Aksaray	0	0	0
69	Bayburt	0	0	0
70	Karaman	0	0	0
71	Kırıkkale	0	0	0
72	Batman	0	0	0
73	Şırnak	0	0	0
74	Bartın	0	0	0
75	Ardahan	0	0	0
76	Iğdır	0	0	0
77	Yalova	0	0	0
78	Karabük	0	0	0
79	Kilis	0	0	0
80	Osmaniye	0	0	0
81	Düzce	0	0	0
6	Ankara	0	3	0
\.


--
-- Data for Name: ilçe; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ilçe" (plakano, postakodu, isim, hastasayisi, doktorsayisi, olusayisi) FROM stdin;
6	6100	Çankaya	0	1	0
6	6750	Akyurt	0	0	0
6	6080	Altındağ	0	0	0
6	6710	Ayaş	0	0	0
6	6726	Bala	0	0	0
6	6730	Beypazarı	0	0	0
6	6740	Çamlıdere	0	0	0
6	6780	Elmadağ	0	0	0
6	6760	Çubuk	0	0	0
6	6794	Etimesgut	0	0	0
6	6770	Evren	0	0	0
6	6830	Gölbaşı	0	0	0
6	6842	Güdül	0	0	0
6	6860	Haymana	0	0	0
6	6980	Kahramankazan	0	0	0
6	6870	Kalecik	0	0	0
6	6300	Keçiören	0	0	0
6	6890	Kızılcahamam	0	0	0
6	6620	Mamak	0	0	0
6	6922	Nallıhan	0	0	0
6	6900	Polatlı	0	0	0
6	6145	Pursaklar	0	0	0
6	6935	Sincan	0	0	0
6	6950	Şereflikoçhisar	0	0	0
6	6560	Yenimahalle	0	0	0
\.


--
-- Data for Name: olasıvakalar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."olasıvakalar" (tckn, ad, soyad, telno, evadresi, isadresi, testtarihi, testdurumu, yas, cinsiyet, kronikhastalik) FROM stdin;
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
2	123456789	sha256$1e7vpEOM$c9b8b27be7f0eb250286a8385034d4cc84401a183d79350de9b7335038c087f3
\.


--
-- Data for Name: vakalar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vakalar (tckn, ilaclistesi, durum) FROM stdin;
\.


--
-- Data for Name: çalışanlar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."çalışanlar" (tckn, password, plakano, hastaneno, ad, soyad, telno, postakodu, tur) FROM stdin;
1234567890000	1234	6	1	A	B	1234567	6100	0
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

