library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ALU is 
	port(
	op1 : in std_logic_vector(7 downto 0);
	op2 : in std_logic_vector(7 downto 0);
	selector : in std_logic_vector(7 downto 0);
	clock : in std_logic;
	flag_c : in std_logic:='0';
	flag_z : in std_logic:='0';
	ret_flag_c : out std_logic:='0';--Flaguri output
	ret_flag_z : out std_logic:='0';
	res : out std_logic_vector(7 downto 0):="00000000";
	enable : in std_logic := '0'
	);
end ALU;

architecture Behavioral of ALU is
signal result : std_logic_vector(7 downto 0):="00000000";
signal add : std_logic_vector(8 downto 0):="000000000";
signal c , z , add_overflow , sub_overflow : std_logic:='0';

begin 							  
    process(op1 , op2 , selector , clock , flag_c , flag_z , enable)
    begin
		if(enable = '1') then
		if rising_edge(clock) then
			add <= "000000000";
            case(selector) is
                when "00000000" =>
					--aici se load
					result <= op2;	
				when "00000001" => 
                    --and pe biti
                    result <= op1 and op2;
					
                when "00000010"=>
                    --or pe biti
                    result <= op1 or op2;
					
                when "00000011"=>
                    --xor pe biti
                    result <= op1 xor op2;
					
				when "00000100" =>
                    --aici se executa adunarea
                    result <= op1 + op2;
                    add <= ('0' & op1) + ('0' & op2);
                
				when "00000101"=>
					--aici se executa adunarea cu carry
					result <= op1 + op2 + flag_c;
                    add <= ('0' & op1) + ('0' & op2) + flag_c;
					
				when "00000110" =>
                    --aici se executa scaderea
                    result <= op1 - op2;
                    add <= ('0' & op1) - ('0' & op2);
                
				when "00000111" =>
                    --aici se executa scaderea cu carry
                    result <= op1 - op2 - flag_c;
                    add <= ('0' & op1) - ('0' & op2) - flag_c;	
					
				when "00001000" =>
                    --incrementare
                    result <= op1 + x"01";
                
				when "00001001" =>
                    --decrementare
                    result <= op1 - x"01";
				
				when others =>
					result <= op1 and "11111111";
			end case;
		end if;
		end if;
    end process;
	
z <= '1' when result = x"00" else '0';
with selector select
    c <= add(8) when "00000100",
    add(8) when "00000101",
	add(8) when "00000110",
	add(8) when "00000111",
	flag_c when "11111111",
    '0' when others;
ret_flag_c <= c;							   
ret_flag_z <= z when not(selector = "11111111") else flag_z;
res <= result;
end architecture;
	
		
					

