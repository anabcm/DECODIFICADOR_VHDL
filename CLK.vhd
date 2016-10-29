LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;    
USE IEEE.STD_LOGIC_UNSIGNED.ALL;    

ENTITY CLK IS  
PORT (   
OSC: IN STD_LOGIC;      
QA,QB,QC,QD: OUT STD_LOGIC
);
END CLK; 
      ARCHITECTURE NARQ OF CLK IS  
         
      BEGIN     
      PROCESS(OSC)    
          VARIABLE  R :STD_LOGIC_VECTOR(1 DOWNTO 0):="00";      
      BEGIN       
      IF(OSC='1') THEN
      CASE  R IS     
      WHEN "00"=>QA<='1';QB<='0';QC<='0';QD<='0';  R:="01";
      WHEN "01"=>QA<='0';QB<='1';QC<='0'; QD<='0'; R:="10"; 
      WHEN "10"=>QA<='0';QB<='0';QC<='1'; QD<='0'; R:="11";
  	  WHEN "11"=>QA<='0';QB<='0';QC<='0'; QD<='1';  R:="00"; 
  	    	        
  	    	        
  	 END CASE;     
      END IF ;
      END PROCESS;
      END NARQ;