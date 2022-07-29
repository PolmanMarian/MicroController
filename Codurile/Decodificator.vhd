library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity InstructionDecoder is
	port
	(
	--INPUT--
	CLK : in std_logic;
	Instructiune : in std_logic_vector(15 downto 0);
	
	--Output---
	WriteAdress : out std_logic_vector (3 downto 0):="0000";
	
	SELMUX : out std_logic := '0';--Adresa2sauConstantData
	SelectorALU : out std_logic_vector(7 downto 0) := "11111111";--Operatia ALU
	SelectorJMP : out std_logic_vector (3 downto 0) := "1111";--Operatia de jump
	
	SX : out std_logic_vector(3 downto 0) := "0000";--reg1
	SY : out std_logic_vector(3 downto 0) := "0000";--reg2	
	KK : out std_logic_vector(7 downto 0) := "00000000";--constant 
	enable : in std_logic := '0'
	);
end entity;
--Tipuri de segmnetare operatie--

--OOOO/S111/KKKK KKKK

--1100/S111/S222/OOOO

--100JMPxx/AAAA AAAA

--1101/S111/00000/SFR

--1101/S111/00001/SFL

--Operatii registru constante

architecture behavior of InstructionDecoder is
--segmentare
signal operatieL:std_logic_vector(3 downto 0):="0000";
signal operatieR:std_logic_vector(3 downto 0):="0000";

signal adress1:std_logic_vector(3 downto 0):="0000";
signal adress2:std_logic_vector(3 downto 0):="0000";   

signal jumpadress:std_logic_vector(7 downto 0):="00000000";

signal const:std_logic_vector(7 downto 0):="00000000";
signal CondJump:std_logic_vector(1 downto 0):="00";

signal ShiftMode:std_logic_vector(2 downto 0):="000";
signal ShiftType:std_logic_vector(4 downto 0):="00000";

begin
--Segmentam in toate modurile--

operatieL<=Instructiune(15 downto 12);
operatieR<=Instructiune(3 downto 0);

adress1<=Instructiune(11 downto 8);
adress2<=Instructiune(7 downto 4);

const<=Instructiune(7 downto 0);	 

jumpadress<=Instructiune(7 downto 0);
condjump<=Instructiune(11 downto 10);

ShiftMode<=Instructiune(2 downto 0);
ShiftType<=Instructiune(7 downto 3);

process(instructiune , clk , enable)
--Cazul de resetare--
begin
	if (enable = '1') then
	if rising_edge(CLK) then
		SelectorJMP <= "1111";
		WriteAdress <= "0000";
		SELMUX <= '0'; --Adresa2sauConstantData
		SelectorALU <= "11111111";
		SX <= "0000";
		SY <= "0000"; --reg2	
		KK <= "00000000";
		--Operatii cu Constanta
		case operatieL is
			when "0000" =>  ---
		  	SELMUX<='1';--1 DA IEI CONSTANTA
			KK<=const;
			SX<=ADRESS1;
			SY<="0000";
			SELECTORALU<="00000000";--LOAD ALU
			WriteAdress<=ADRESS1;
			
			when "0001" =>  ---AND
		  	SELMUX<='1';
			KK<=const;
			SX<=ADRESS1;
			SY<="0000";
			SELECTORALU<="00000001";--AND ALU
			WriteAdress<=ADRESS1;
			
			when "0010" =>  ---OR
		  	SELMUX<='1';
			KK<=const;
			SX<=ADRESS1;
			SY<="0000";
			SELECTORALU<="00000010";--OR ALU
			WriteAdress<=ADRESS1;
			
			when "0011" =>  ---XOR
		  	SELMUX<='1';
			KK<=const;
			SX<=ADRESS1;
			SY<="0000";
			SELECTORALU<="00000011";--XOR ALU
			WriteAdress<=ADRESS1;
			
			when "0100" =>  ---ADD
			SELMUX<='1';
			KK<=const;
			SX<=ADRESS1;
			SY<="0000";
			SELECTORALU<="00000100";--ADD ALU
			WriteAdress<=ADRESS1;
			
			when "0101" =>  ---ADDCY
			SELMUX<='1';
			KK<=const;
			SX<=ADRESS1;
			SY<="0000";
			SELECTORALU<="00000101";--ANDCY
			WriteAdress<=ADRESS1;
			
			when "0110" =>  ---SUB
		  	SELMUX<='1';
			KK<=const;
			SX<=ADRESS1;				  		
			SY<="0000";
			SELECTORALU<="00000110";--SUB ALU
			WriteAdress<=ADRESS1;
			
			when "0111" =>  ---SUBCY
			SELMUX<='1';
			KK<=const;
			SX<=ADRESS1;				  		
			SY<="0000";
			SELECTORALU<="00000111";--SUBCY ALU
			WriteAdress<=ADRESS1;
			
			--Operatii intre registrii--
			
			--Jump neconditionat		
			when "1000" =>
			KK<=const;
			SelectorJMP<="0000";--JUMP NECONDITIONAT;
			
			when "1001" =>
			KK<=const;
				case condjump is
					when "00" =>--IF ZERO -_-
						SelectorJMP<="0001";
					when "01" =>--IF NOT ZERO 0_0
						SelectorJMP<="0010";		
					when "10" =>--IF CRY !_!
						SelectorJMP<="0011";
					when "11" =>--IF NOT CRY :'(
						SelectorJMP<="0100";
					when others =>
						SelectorJMP<="ZZZZ";--NIMIC
				end case;
			---Operatii intre registrii--
			when "1100" =>
				SELMUX<='0';--La 0 incarci reg2
				KK<="00000000";
				SX<=ADRESS1;				  		
				SY<=ADRESS2;
				case operatieR is
					when "0000" =>
					SelectorALU<="00000000";
					when "0001" =>
					SelectorALU<="00000001";
					when "0010" =>
					SelectorALU<="00000010";
					when "0011" =>
					SelectorALU<="00000011";
					when "0100" =>
					SelectorALU<="00000100";
					when "0101" =>
					SelectorALU<="00000101";
					when "0110" =>
					SelectorALU<="00000110";
					when "0111" =>
					SelectorALU<="00000111";
					when others =>
					SelectorALU<="00000000";--NIMIC
				end case;
				WriteAdress<=ADRESS1;
			
			---Shiftari---	
			when "1101" =>
				SELMUX<='0';
				KK<="00000000";
				SX<=ADRESS1;				  		
				SY<="0000";
				case ShiftType is
					when "00000" => --Shift Left
						case ShiftMode is
							when "110"	=>
							SelectorALU<="00001000";--SL0
							when "111"	=>
							SelectorALU<="00001001";--SL1
							when "010"	=>
							SelectorALU<="00001010";--SLX
							when "000"	=>
							SelectorALU<="00001011";--SLA
							when "100"	=>
							SelectorALU<="00001100";--RL
							when others	=>
							SelectorALU<="11111111";--nimic
						end case;
					when "00001" => --Shift Right
						case ShiftMode is
							when "110"	=>
							SelectorALU<="00001101";--SR0
							when "111"	=>
							SelectorALU<="00001110";--SR1
							when "010"	=>
							SelectorALU<="00001111";--SRX
							when "000"	=>
							SelectorALU<="00010000";--SRA
							when "100"	=>
							SelectorALU<="00010001";--RR
							when others	=>
							SelectorALU<="11111111";--nimic
						end case;
					when others =>
					SelectorALU <= "11111111";--NIMIC
				end case;
				WriteAdress <= ADRESS1;
			when "1111" =>
            KK<="00000000";
            SelectorJMP<="0000";
			when others =>
			SX <= "0000";
			SY <= "0001";
		end case;
		end if;
		end if;
		end process;
	end architecture;