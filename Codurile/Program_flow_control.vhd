library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Program_flow_control is
	port(
	constant_data : in std_logic_vector(7 downto 0);
	operation : in std_logic_vector(3 downto 0);
	clock : in std_logic;
	carry : in std_logic;
	zerro : in std_logic;
	flag_citire : out std_logic := '0';
	adresa_noua : out std_logic_vector(7 downto 0) := "00000000";
	enable : in std_logic := '0'
	);
end Program_flow_control;

architecture Behavior of Program_flow_control is
begin
	process(operation , constant_data , clock , carry , zerro)
	begin
		if enable = '1' then
		if rising_edge(clock) then	
			flag_citire <= '0';
			case operation is
				
				when "0000" => -- jump
					adresa_noua <=	constant_data;
					flag_citire <= '1';
					
				when "0001" => -- jump z
					if zerro = '1' then
						adresa_noua <= constant_data;
						flag_citire <= '1';
					else
						flag_citire <= '0';
					end if;
				
				when "0010" => -- jump nz
					if zerro = '0' then
						adresa_noua <= constant_data;
						flag_citire <= '1';
					else
						flag_citire <= '0';
					end if;
				
				when "0011" => -- jump c
					if carry = '1' then
						adresa_noua <= constant_data;
						flag_citire <= '1';
					else
						flag_citire <= '0';
					end if;
				
				when "0100"	=> -- jump nc
					if carry = '0' then
						adresa_noua <= constant_data;
						flag_citire <= '1';
					else
						flag_citire <= '0';
					end if;
					
				when others	=>
					flag_citire <= '0';
			end case;
		end if;
		end if;
	end process;
end architecture;

		
	