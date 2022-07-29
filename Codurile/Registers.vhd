library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Registers is
	port(
	clock: in std_logic;
	reg_1 : out std_logic_vector(7 downto 0):="00000000";
	reg_2 : out std_logic_vector(7 downto 0):="00000000";
	sel_adresa : in std_logic_vector(3 downto 0);
	we : in std_logic;
	ad1 : in std_logic_vector(3 downto 0);
	ad2 : in std_logic_vector(3 downto 0);
	write : in std_logic_vector(7 downto 0);
	reset : in std_logic;
	enable : in std_logic
	);
end Registers;

architecture Behavioral of Registers is
type rom_array is array (0 to 15) of std_logic_vector(7 downto 0);
signal rom : rom_array := ("00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000",
"00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000");
begin
	process(clock , reset , sel_adresa , ad1 , ad2 , write , we , enable)
	begin
	if reset = '1' then
		rom <= ("00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000",
				"00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000");
	elsif enable = '1' then
		if rising_edge(clock) then
		if we = '1' then
			rom(to_integer(unsigned(sel_adresa)))<=write;
		else
			reg_1 <= rom(to_integer(unsigned(ad1)));
			reg_2 <= rom(to_integer(unsigned(ad2)));
		end if;
		end if;
	end if;
	end process;
end architecture;