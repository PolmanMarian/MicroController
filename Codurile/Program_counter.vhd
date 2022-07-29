library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Program_counter is
	port(
	new_adress : in std_logic_vector(7 downto 0);
	flag_citire : in std_logic;
	clock : in std_logic;
	adress : out std_logic_vector(7 downto 0):="00000000"; -- output
	reset:in std_logic;
	enable : in std_logic := '0'
	);
end Program_counter;

architecture Behavioral of Program_counter is
signal tmp : std_logic_vector(7 downto 0) := "00000000";
begin
	process(clock , enable , reset , new_adress , flag_citire)
	begin
		if reset = '1' then
					tmp <= "00000000";	
		elsif enable = '1' then
			if rising_edge(clock) then
					if flag_citire = '1' then
					tmp <= new_adress;
					else
					tmp <= tmp + '1';
					end if;
			end if;
		end if;
		adress <= tmp;
	end process;
end architecture;
			