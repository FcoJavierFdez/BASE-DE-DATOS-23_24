CREATE DEFINER=`root`@`localhost` PROCEDURE `verIdCompradas`(
IN partidoP VARCHAR(4), OUT personasCompradas INTEGER)
BEGIN
DECLARE partidoValido VARCHAR(4);
SELECT COUNT(*) INTO partidoValido FROM senador
WHERE partido = partidoP;
IF partidoValido = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Operación no permitida\n*****\n====> Mensaje de error.\n*****\n';
ELSE  SELECT COUNT(*) INTO personasCompradas
         FROM id_digital
         WHERE comprado = '1' 
         AND senador_corrupto IN (SELECT dni FROM senador
											 WHERE partido = partidoP);
         SELECT id, circunscripcion FROM id_digital
	     WHERE comprado = '1' 
         AND senador_corrupto IN (SELECT dni FROM senador
												WHERE partido = partidoP)
         ORDER BY circunscripcion;
END IF;
END