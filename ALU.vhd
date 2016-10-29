LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;   
USE IEEE.STD_LOGIC_UNSIGNED.ALL;      
USE IEEE.NUMERIC_BIT.ALL       ;

ENTITY ALU IS  
PORT   (      
 CLKC: IN   STD_LOGIC;
 INP: IN   STD_LOGIC_VECTOR(4 DOWNTO 0);
 ENTRADA: IN   STD_LOGIC_VECTOR(7 DOWNTO 0);     
 SALIDA: OUT   STD_LOGIC_VECTOR(7 DOWNTO 0);           
 BIT_OPERAR: IN  STD_LOGIC_VECTOR(2 DOWNTO 0); 
 WREG: IN STD_LOGIC_VECTOR(7 DOWNTO 0);       
 ALTA_IMPEDANCIA: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
 STATUSA:OUT STD_LOGIC_VECTOR(2 DOWNTO 0) --SALIDA AL STATUS DE CARRY,Z,DC
);
END ALU;
ARCHITECTURE NARQ OF ALU IS
BEGIN    
PROCESS (CLKC,ALTA_IMPEDANCIA)
VARIABLE AUX: STD_LOGIC_VECTOR(7 DOWNTO 0); 
VARIABLE AUX2: STD_LOGIC_VECTOR(3 DOWNTO 0); 

   BEGIN   
   IF(ALTA_IMPEDANCIA="000") THEN
 		SALIDA<="ZZZZZZZZ";
	END IF;
   
   CASE   INP IS    
   		 WHEN "00001"=>NULL;              --NOP
   		 WHEN "00010"=>SALIDA<=ENTRADA;   --MOVWF
   		 WHEN "00011"=>SALIDA<="00000000";   	--CLRF  
   		 WHEN "00100"=>SALIDA<="00000000";   	--CLRW
         WHEN "00101" =>SALIDA<= WREG-ENTRADA; --SUBLW
         WHEN "00110" =>SALIDA<=ENTRADA-1;--DECF  
         WHEN "00111" =>SALIDA<=ENTRADA OR WREG;--IORWF 
         WHEN "01000" =>SALIDA<=ENTRADA AND WREG;--ANDwf 
          WHEN "01001" =>SALIDA<=(WREG XOR  ENTRADA);--xORLW    
         WHEN "01010" =>SALIDA<=ENTRADA+WREG;--ADDWF 
         WHEN "01011" =>SALIDA<=ENTRADA ;--MOVF  
         WHEN "01100" =>SALIDA<=NOT ENTRADA ;  --COMF
         WHEN "01101" =>SALIDA<=ENTRADA+1 ;    --INCF
         WHEN "01110" =>SALIDA<=ENTRADA-1;  --FALTA SKIP IF 0
         WHEN "01111" =>SALIDA<= ENTRADA ROR 1;--RRF
         WHEN "10000" =>SALIDA<= ENTRADA ROL 1;--RLF
         WHEN "10001" =>AUX(7 DOWNTO 4):=ENTRADA(3 DOWNTO 0);AUX(3 DOWNTO 0):=ENTRADA(7 DOWNTO 4);SALIDA<=AUX;    --SWAPF
         WHEN "10010" =>SALIDA<=  ENTRADA+1;--INCFSZ FALTA SKIP IF 0
         WHEN "10011" =>  --BCF  
                  CASE  BIT_OPERAR IS  
                  WHEN "000"=>ENTRADA(0)<='0';SALIDA<=ENTRADA; 
                  WHEN "001"=>ENTRADA(1)<='0';SALIDA<=ENTRADA;  
                  WHEN "010"=>ENTRADA(2)<='0';SALIDA<=ENTRADA;
				  WHEN "011"=>ENTRADA(3)<='0';SALIDA<=ENTRADA;
				  WHEN "100"=>ENTRADA(4)<='0';SALIDA<=ENTRADA;
				  WHEN "101"=>ENTRADA(5)<='0';SALIDA<=ENTRADA;
				  WHEN "110"=>ENTRADA(6)<='0';SALIDA<=ENTRADA;
				  WHEN "111"=>ENTRADA(7)<='0';SALIDA<=ENTRADA; 
                  END CASE;    --BCF
          WHEN "10100" =>  --BSF  
                  CASE  BIT_OPERAR IS  
                  WHEN "000"=>ENTRADA(0)<='1';SALIDA<=ENTRADA; 
                  WHEN "001"=>ENTRADA(1)<='1';SALIDA<=ENTRADA;  
                  WHEN "010"=>ENTRADA(2)<='1';SALIDA<=ENTRADA;
				  WHEN "011"=>ENTRADA(3)<='1';SALIDA<=ENTRADA;
				  WHEN "100"=>ENTRADA(4)<='1';SALIDA<=ENTRADA;
				  WHEN "101"=>ENTRADA(5)<='1';SALIDA<=ENTRADA;
				  WHEN "110"=>ENTRADA(6)<='1';SALIDA<=ENTRADA;
				  WHEN "111"=>ENTRADA(7)<='1';SALIDA<=ENTRADA; 
                  END CASE;  
         WHEN "10101" =>  --BTFSC     
         CASE  BIT_OPERAR IS  
                  WHEN "000"=>IF(ENTRADA(0) ='0') THEN SALIDA<=ENTRADA+1; END IF;
                  WHEN "001"=>IF(ENTRADA(1) ='0') THEN SALIDA<=ENTRADA+1; END IF;
                  WHEN "010"=>IF(ENTRADA(2) ='0') THEN SALIDA<=ENTRADA+1; END IF;
                  WHEN "011"=>IF(ENTRADA(3) ='0') THEN SALIDA<=ENTRADA+1;END IF; 
                  WHEN "100"=>IF(ENTRADA(4) ='0') THEN SALIDA<=ENTRADA+1;END IF; 
                  WHEN "101"=>IF(ENTRADA(5) ='0') THEN SALIDA<=ENTRADA+1;END IF; 
                  WHEN "110"=>IF(ENTRADA(6) ='0') THEN SALIDA<=ENTRADA+1;END IF;
                  WHEN "111"=>IF(ENTRADA(7) ='0') THEN SALIDA<=ENTRADA+1;END IF; 
          END CASE;    
                                           
 
         WHEN "10110" =>  --BTFSS      
       CASE  BIT_OPERAR IS  
                  WHEN "000"=>IF(ENTRADA(0) ='1') THEN SALIDA<=ENTRADA+1;END IF; 
                  WHEN "001"=>IF(ENTRADA(1) ='1') THEN SALIDA<=ENTRADA+1;END IF;      --SUMAMOS 1 AL PC PARA QUE SALTE UNA INSTRUCCION
                  WHEN "010"=>IF(ENTRADA(2) ='1') THEN SALIDA<=ENTRADA+1;END IF; 
                  WHEN "011"=>IF(ENTRADA(3) ='1') THEN SALIDA<=ENTRADA+1;END IF; 
                  WHEN "100"=>IF(ENTRADA(4) ='1') THEN SALIDA<=ENTRADA+1;END IF; 
                  WHEN "101"=>IF(ENTRADA(5) ='1') THEN SALIDA<=ENTRADA+1;END IF; 
                  WHEN "110"=>IF(ENTRADA(6) ='1') THEN SALIDA<=ENTRADA+1; END IF;
                  WHEN "111"=>IF(ENTRADA(7) ='1') THEN SALIDA<=ENTRADA+1; END IF;
          END CASE;  
           
          --FALTA CALL Y GOTO PARA PROGRAM CONUNTER 
                                                                                                                  
         WHEN "11001" =>SALIDA<=  ENTRADA+WREG;--ADDLW                                                          
         WHEN "11001" =>SALIDA<= ( ENTRADA AND WREG);--ANDLW 
         WHEN "11110" =>SALIDA<= ENTRADA; --MOVLW
         WHEN "11100" =>SALIDA<=(WREG OR  ENTRADA);--IORLW      
         WHEN "00101" =>SALIDA<= ENTRADA-WREG;  --SUBLW
         WHEN "11011" =>SALIDA<=(WREG XOR  ENTRADA);--xORLW     
   
   END CASE;
   END PROCESS;
   END   NARQ;
