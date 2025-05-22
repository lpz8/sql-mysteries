-- Team Challenge Unidad 3 Sprint 12 - Misterio de asesinato de SQL
-- Paso 1: Explorar las tablas
SELECT name FROM sqlite_master WHERE type = 'table';
-- Resultado: crime_scene_report, person, interview, etc.

-- Paso 2: Explorar la estructura de crime_scene_report
SELECT sql FROM sqlite_master WHERE name = 'crime_scene_report';
-- Resultado: Definición de la tabla

-- Paso 3: Buscar el informe del crimen
SELECT description FROM crime_scene_report WHERE date = 20180115 AND type = 'murder' AND city = 'SQL City';
-- Resultado: "Security footage shows that there were 2 witnesses..."

-- Paso 4: Encontrar a los testigos
-- Testigo 1
SELECT p.id, p.name, p.address_street_name, p.address_number FROM person p WHERE p.address_street_name = 'Northwestern Dr' ORDER BY p.address_number DESC LIMIT 1;
-- Resultado: 14887, Morty Schapiro, Northwestern Dr, 4919
-- Testigo 2
SELECT p.id, p.name, p.address_street_name FROM person p WHERE p.name LIKE '%Annabel%' AND p.address_street_name = 'Franklin Ave';
-- Resultado: 16371, Annabel Miller, Franklin Ave

-- Paso 5: Revisar las declaraciones
SELECT i.person_id, i.transcript FROM interview i WHERE i.person_id IN (14887, 16371);
-- Resultado: 14887: "I heard a gunshot...", 16371: "I saw the murder..."

-- Paso 6: Seguir las pistas del gimnasio
-- Miembros gold
SELECT m.id, m.person_id, m.name, m.membership_status FROM get_fit_now_member m WHERE m.id LIKE '48Z%' AND m.membership_status = 'gold';
-- Resultado: 48Z7A, 28819, Joe Germuska, gold; 48Z55, 67318, Jeremy Bowers, gold
-- Check-in el 9 de enero
SELECT c.membership_id, c.check_in_date FROM get_fit_now_check_in c WHERE c.check_in_date = 20180109 AND c.membership_id IN ('48Z7A', '48Z55');
-- Resultado: 48Z55, 20180109

-- Paso 7: Verificar la placa
SELECT p.id, p.name, dl.plate_number FROM person p JOIN drivers_license dl ON p.license_id = dl.id WHERE p.id IN (28819, 67318) AND dl.plate_number LIKE '%H42W%';
-- Resultado: 67318, Jeremy Bowers, 0H42W2

-- Paso 8: Confirmar al asesino
INSERT INTO solution VALUES (1, 'Jeremy Bowers');
SELECT value FROM solution;
-- Resultado: Jeremy Bowers

-- Paso 9 (Opcional): Buscar al cerebro
-- Encontrar a la mujer
SELECT p.id, p.name, dl.height, dl.hair_color, dl.car_make, dl.car_model FROM person p JOIN drivers_license dl ON p.license_id = dl.id WHERE dl.gender = 'female' AND dl.height BETWEEN 65 AND 67 AND dl.hair_color = 'red' AND dl.car_make = 'Tesla' AND dl.car_model = 'Model S';
-- Resultado: 99716, Miranda Priestly, 66, red, Tesla, Model S
-- Verificar asistencia
SELECT person_id, event_name, date FROM facebook_event_checkin WHERE person_id = 99716 AND event_name = 'SQL Symphony Concert' AND date LIKE '201712%';
-- Resultado: 3 asistencias