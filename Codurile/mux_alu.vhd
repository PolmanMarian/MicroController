library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_alu is
	port(
	a : in std_logic_vector(7 downto 0);
	b : in std_logic_vector(7 downto 0);
	selector : in std_logic;
	o : out std_logic_vector(7 downto 0) := "00000000"
	);
end mux_alu;

architecture Behavioral of mux_alu is
begin
	process(selector , a , b)
	begin
		if selector = '0' then
			o <= a;
		else
			o <= b;
		end if;
	end process;	
end architecture;
	