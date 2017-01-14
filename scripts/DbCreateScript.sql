--
-- PostgreSQL database dump
--
-- You need to create a DB first and then run this script on the DB.  

-- Dumped from database version 9.6.1
-- Dumped by pg_dump version 9.6.1

-- Started on 2017-01-14 10:12:06

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2172 (class 1262 OID 16393)
-- Dependencies: 2171
-- Name: RefugeeDB; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE RefugeeDB IS 'Database to house global good tables/information';


--
-- TOC entry 8 (class 2615 OID 16395)
-- Name: caseworker; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA caseworker;


ALTER SCHEMA caseworker OWNER TO postgres;

--
-- TOC entry 2173 (class 0 OID 0)
-- Dependencies: 8
-- Name: SCHEMA caseworker; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA caseworker IS 'Information about the person that worked the case';


--
-- TOC entry 9 (class 2615 OID 16405)
-- Name: events; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA events;


ALTER SCHEMA events OWNER TO postgres;

--
-- TOC entry 5 (class 2615 OID 16394)
-- Name: refugee; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA refugee;


ALTER SCHEMA refugee OWNER TO postgres;

--
-- TOC entry 2175 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA refugee; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA refugee IS 'Information about the refugee ';


--
-- TOC entry 1 (class 3079 OID 12387)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2176 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = caseworker, pg_catalog;

--
-- TOC entry 197 (class 1255 OID 16782)
-- Name: delete_caseworkerprofile(integer); Type: FUNCTION; Schema: caseworker; Owner: postgres
--

CREATE FUNCTION delete_caseworkerprofile(caseid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
Begin
   -- removes the event
   Delete from caseworker.caseworkerprofile where caseworkerid = caseid;
END;
$$;


ALTER FUNCTION caseworker.delete_caseworkerprofile(caseid integer) OWNER TO postgres;

--
-- TOC entry 194 (class 1255 OID 16731)
-- Name: insert_caseworkerprofile(character varying, character, character, character); Type: FUNCTION; Schema: caseworker; Owner: postgres
--

CREATE FUNCTION insert_caseworkerprofile(fname character varying, lname character, phone character, email character) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
   v_CaseWorkerId integer;
BEGIN
   -- Inserts the new person record and retrieves the last inserted id
   INSERT INTO caseworker.caseworkerprofile(Fname, Lname,Phone,Email)
   VALUES (Fname,Lname,Phone,Email)
   RETURNING caseworkerid INTO v_CaseWorkerId;

   -- Return the new id so we can use it in a select clause or return the new id into the user application
    RETURN v_CaseWorkerId;
END;
$$;


ALTER FUNCTION caseworker.insert_caseworkerprofile(fname character varying, lname character, phone character, email character) OWNER TO postgres;

--
-- TOC entry 212 (class 1255 OID 16790)
-- Name: update_caseworkerprofile(integer, character, character, character, character, boolean); Type: FUNCTION; Schema: caseworker; Owner: postgres
--

CREATE FUNCTION update_caseworkerprofile(id integer, firstname character, lastname character, phonenumber character, emailaddress character, activeprofile boolean) RETURNS void
    LANGUAGE plpgsql
    AS $$

BEGIN
   -- updates the data in refugeeprofile
   Update caseworker.caseworkerprofile
   Set  fname = firstname,lname=lastname,phone=phonenumber,email=emailaddress,active=activeprofile
   where caseworkerid = id;


END;

$$;


ALTER FUNCTION caseworker.update_caseworkerprofile(id integer, firstname character, lastname character, phonenumber character, emailaddress character, activeprofile boolean) OWNER TO postgres;

SET search_path = events, pg_catalog;

--
-- TOC entry 196 (class 1255 OID 16781)
-- Name: delete_refugeevent(integer); Type: FUNCTION; Schema: events; Owner: postgres
--

CREATE FUNCTION delete_refugeevent(eventid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
Begin
   -- removes the event
   Delete from events.refugeevent where refugeeventid = eventid;
END;
$$;


ALTER FUNCTION events.delete_refugeevent(eventid integer) OWNER TO postgres;

--
-- TOC entry 211 (class 1255 OID 16778)
-- Name: insert_refugeevent(integer, integer, integer, text, timestamp without time zone, boolean); Type: FUNCTION; Schema: events; Owner: postgres
--

CREATE FUNCTION insert_refugeevent(eventnumber integer, refugeeid integer, caseworkerid integer, eventnotes text, dateofincident timestamp without time zone, highpriority911 boolean) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
   v_refugeeventid integer;
BEGIN
   -- Inserts the new person recordregfugeeand retrieves the last inserted id
   INSERT INTO events.refugeevent(eventnumber,refugeeid,caseworkerid,eventnotes,dateofincident,highpriority911)
   VALUES (eventnumber,refugeeid,caseworkerid,eventnotes,dateofincident,highpriority911)
   RETURNING refugeeventid INTO v_refugeeventid;

   -- Return the new id so we can use it in a select clause or return the new id into the user application
    RETURN v_refugeeventid;
END;
$$;


ALTER FUNCTION events.insert_refugeevent(eventnumber integer, refugeeid integer, caseworkerid integer, eventnotes text, dateofincident timestamp without time zone, highpriority911 boolean) OWNER TO postgres;

--
-- TOC entry 214 (class 1255 OID 16791)
-- Name: update_refugeevent(integer, integer, integer, integer, text, timestamp without time zone, boolean); Type: FUNCTION; Schema: events; Owner: postgres
--

CREATE FUNCTION update_refugeevent(id integer, eventnum integer, refid integer, caseid integer, notes text, dateincident timestamp without time zone, priority911 boolean) RETURNS void
    LANGUAGE plpgsql
    AS $$

BEGIN
   -- updates the data in refugeeprofile
   Update events.refugeevent
   Set eventnumber=eventnum,refugeeid=refid,caseworkerid=caseid,eventnotes=notes,dateofincident=dateincident,highpriority911=priority911
   where refugeeventid = id;


END;

$$;


ALTER FUNCTION events.update_refugeevent(id integer, eventnum integer, refid integer, caseid integer, notes text, dateincident timestamp without time zone, priority911 boolean) OWNER TO postgres;

SET search_path = refugee, pg_catalog;

--
-- TOC entry 198 (class 1255 OID 16784)
-- Name: delete_refugeeprofile(integer); Type: FUNCTION; Schema: refugee; Owner: postgres
--

CREATE FUNCTION delete_refugeeprofile(refugee integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
Begin
   -- removes the event
   Delete from refugee.refugeeprofile where refugeeid = refugee;
END;
$$;


ALTER FUNCTION refugee.delete_refugeeprofile(refugee integer) OWNER TO postgres;

--
-- TOC entry 195 (class 1255 OID 16732)
-- Name: insert_refugeeprofile(character varying, character, character, character); Type: FUNCTION; Schema: refugee; Owner: postgres
--

CREATE FUNCTION insert_refugeeprofile(fname character varying, lname character, phone character, email character) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
   v_refugeeid integer;
BEGIN
   -- Inserts the new person recordregfugeeand retrieves the last inserted id
   INSERT INTO refugee.refugeeProfile(Fname, Lname,Phone,Email)
   VALUES (Fname,Lname,Phone,Email)
   RETURNING refugeeid INTO v_refugeeid;

   -- Return the new id so we can use it in a select clause or return the new id into the user application
    RETURN v_refugeeid;
END;
$$;


ALTER FUNCTION refugee.insert_refugeeprofile(fname character varying, lname character, phone character, email character) OWNER TO postgres;

--
-- TOC entry 213 (class 1255 OID 16788)
-- Name: update_refugeeprofile(integer, character, character, character, character); Type: FUNCTION; Schema: refugee; Owner: postgres
--

CREATE FUNCTION update_refugeeprofile(id integer, firstname character, lastname character, phonenumber character, emailaddress character) RETURNS void
    LANGUAGE plpgsql
    AS $$

BEGIN
   -- updates the data in refugeeprofile
   Update refugee.refugeeProfile
   Set  fname = firstname,lname=lastname,phone=phonenumber,email=emailaddress
   where refugeeid = id;


END;

$$;




ALTER FUNCTION refugee.update_refugeeprofile(id integer, firstname character, lastname character, phonenumber character, emailaddress character) OWNER TO postgres;

SET search_path = caseworker, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 189 (class 1259 OID 16735)
-- Name: caseworkerprofile; Type: TABLE; Schema: caseworker; Owner: postgres
--

CREATE TABLE caseworkerprofile (
    caseworkerid integer NOT NULL,
    fname character(255) NOT NULL,
    lname character(255) NOT NULL,
    phone character(50),
    email character(255),
    active boolean DEFAULT true,
    createdate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE caseworkerprofile OWNER TO postgres;

--
-- TOC entry 188 (class 1259 OID 16733)
-- Name: caseworkerprofile_caseworkerid_seq; Type: SEQUENCE; Schema: caseworker; Owner: postgres
--

CREATE SEQUENCE caseworkerprofile_caseworkerid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE caseworkerprofile_caseworkerid_seq OWNER TO postgres;

--
-- TOC entry 2177 (class 0 OID 0)
-- Dependencies: 188
-- Name: caseworkerprofile_caseworkerid_seq; Type: SEQUENCE OWNED BY; Schema: caseworker; Owner: postgres
--

ALTER SEQUENCE caseworkerprofile_caseworkerid_seq OWNED BY caseworkerprofile.caseworkerid;


SET search_path = events, pg_catalog;

--
-- TOC entry 193 (class 1259 OID 16760)
-- Name: refugeevent; Type: TABLE; Schema: events; Owner: postgres
--

CREATE TABLE refugeevent (
    refugeeventid integer NOT NULL,
    eventnumber integer NOT NULL,
    refugeeid integer,
    caseworkerid integer DEFAULT 0,
    eventnotes text,
    dateofincident timestamp without time zone,
    highpriority911 boolean DEFAULT false,
    createdate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE refugeevent OWNER TO postgres;

--
-- TOC entry 192 (class 1259 OID 16758)
-- Name: refugeevent_refugeeventid_seq; Type: SEQUENCE; Schema: events; Owner: postgres
--

CREATE SEQUENCE refugeevent_refugeeventid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE refugeevent_refugeeventid_seq OWNER TO postgres;

--
-- TOC entry 2178 (class 0 OID 0)
-- Dependencies: 192
-- Name: refugeevent_refugeeventid_seq; Type: SEQUENCE OWNED BY; Schema: events; Owner: postgres
--

ALTER SEQUENCE refugeevent_refugeeventid_seq OWNED BY refugeevent.refugeeventid;


SET search_path = refugee, pg_catalog;

--
-- TOC entry 191 (class 1259 OID 16748)
-- Name: refugeeprofile; Type: TABLE; Schema: refugee; Owner: postgres
--

CREATE TABLE refugeeprofile (
    refugeeid integer NOT NULL,
    fname character(255) NOT NULL,
    lname character(255) NOT NULL,
    phone character(50),
    email character(255),
    createdate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE refugeeprofile OWNER TO postgres;

--
-- TOC entry 190 (class 1259 OID 16746)
-- Name: refugeeprofile_refugeeid_seq; Type: SEQUENCE; Schema: refugee; Owner: postgres
--

CREATE SEQUENCE refugeeprofile_refugeeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE refugeeprofile_refugeeid_seq OWNER TO postgres;

--
-- TOC entry 2179 (class 0 OID 0)
-- Dependencies: 190
-- Name: refugeeprofile_refugeeid_seq; Type: SEQUENCE OWNED BY; Schema: refugee; Owner: postgres
--

ALTER SEQUENCE refugeeprofile_refugeeid_seq OWNED BY refugeeprofile.refugeeid;


SET search_path = caseworker, pg_catalog;

--
-- TOC entry 2028 (class 2604 OID 16738)
-- Name: caseworkerprofile caseworkerid; Type: DEFAULT; Schema: caseworker; Owner: postgres
--

ALTER TABLE ONLY caseworkerprofile ALTER COLUMN caseworkerid SET DEFAULT nextval('caseworkerprofile_caseworkerid_seq'::regclass);


SET search_path = events, pg_catalog;

--
-- TOC entry 2033 (class 2604 OID 16763)
-- Name: refugeevent refugeeventid; Type: DEFAULT; Schema: events; Owner: postgres
--

ALTER TABLE ONLY refugeevent ALTER COLUMN refugeeventid SET DEFAULT nextval('refugeevent_refugeeventid_seq'::regclass);


SET search_path = refugee, pg_catalog;

--
-- TOC entry 2031 (class 2604 OID 16751)
-- Name: refugeeprofile refugeeid; Type: DEFAULT; Schema: refugee; Owner: postgres
--

ALTER TABLE ONLY refugeeprofile ALTER COLUMN refugeeid SET DEFAULT nextval('refugeeprofile_refugeeid_seq'::regclass);


SET search_path = caseworker, pg_catalog;


--
-- TOC entry 2180 (class 0 OID 0)
-- Dependencies: 188
-- Name: caseworkerprofile_caseworkerid_seq; Type: SEQUENCE SET; Schema: caseworker; Owner: postgres
--

SELECT pg_catalog.setval('caseworkerprofile_caseworkerid_seq', 5, true);


SET search_path = events, pg_catalog;
-- TOC entry 2181 (class 0 OID 0)
-- Dependencies: 192
-- Name: refugeevent_refugeeventid_seq; Type: SEQUENCE SET; Schema: events; Owner: postgres
--

SELECT pg_catalog.setval('refugeevent_refugeeventid_seq', 7, true);


SET search_path = refugee, pg_catalog;

--
-- TOC entry 2182 (class 0 OID 0)
-- Dependencies: 190
-- Name: refugeeprofile_refugeeid_seq; Type: SEQUENCE SET; Schema: refugee; Owner: postgres
--

SELECT pg_catalog.setval('refugeeprofile_refugeeid_seq', 8, true);


SET search_path = caseworker, pg_catalog;

--
-- TOC entry 2038 (class 2606 OID 16745)
-- Name: caseworkerprofile caseworkerprofile_pkey; Type: CONSTRAINT; Schema: caseworker; Owner: postgres
--

ALTER TABLE ONLY caseworkerprofile
    ADD CONSTRAINT caseworkerprofile_pkey PRIMARY KEY (caseworkerid);


SET search_path = events, pg_catalog;

--
-- TOC entry 2042 (class 2606 OID 16771)
-- Name: refugeevent refugeevent_pkey; Type: CONSTRAINT; Schema: events; Owner: postgres
--

ALTER TABLE ONLY refugeevent
    ADD CONSTRAINT refugeevent_pkey PRIMARY KEY (refugeeventid);


SET search_path = refugee, pg_catalog;

--
-- TOC entry 2040 (class 2606 OID 16757)
-- Name: refugeeprofile refugeeprofile_pkey; Type: CONSTRAINT; Schema: refugee; Owner: postgres
--

ALTER TABLE ONLY refugeeprofile
    ADD CONSTRAINT refugeeprofile_pkey PRIMARY KEY (refugeeid);


SET search_path = events, pg_catalog;

--
-- TOC entry 2043 (class 2606 OID 16772)
-- Name: refugeevent refugeevent_refugeeid_fkey; Type: FK CONSTRAINT; Schema: events; Owner: postgres
--

ALTER TABLE ONLY refugeevent
    ADD CONSTRAINT refugeevent_refugeeid_fkey FOREIGN KEY (refugeeid) REFERENCES refugee.refugeeprofile(refugeeid);


-- Completed on 2017-01-14 10:12:06

--
-- PostgreSQL database dump complete
--


CREATE OR REPLACE FUNCTION events.Get_refugeevent(
    id int)
    RETURNS void 
    LANGUAGE 'plpgsql'
    COST 100.0
    VOLATILE NOT LEAKPROOF 
AS $function$

BEGIN
--TODO This has a bug and is not working pdw 01-14-17
   -- updates the data in refugeeprofile
   Select refugeeventid,eventnumber,refugeeid,caseworkerid,eventnotes,dateofincident,highpriority911
   from events.refugeevent  
   where refugeeventid = id;

END;

$function$;