library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity numarator_binar is 
	port(
	clock , start : in std_logic;
	valoare : out std_logic_vector(2 downto 0) := "000"
	);
end numarator_binar;

architecture arc of numarator_binar is
signal tmp : std_logic_vector(2 downto 0) := "000";
begin
	process(clock , start)
	begin
	if rising_edge(clock) then
	
	if tmp = "000" and start = '1' then
		tmp <= tmp + 1;
	else
		if not(tmp = "000") then
			tmp <= tmp + 1;
		end if;
	end if;
	end if;
	end process;   
	valoare <= tmp;
end architecture;


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity decoder_clock is
	port(
	intrare : in std_logic_vector(2 downto 0);
	output  : out std_logic_vector(7 downto 0) := "00000000"
	);
end decoder_clock;

architecture Beh_decoder_clock of decoder_clock is
begin
	process(intrare)
	begin
		case intrare is
			when "001" =>
			output <= "00000001";
			when "010" =>
			output <= "00000010";
			when "011" =>
			output <= "00000100";
			when "100" => 
			output <= "00001000";
			when "101" => 
			output <= "00010000";
			when "110" => 
			output <= "00100000";
			when "111" => 
			output <= "01000000";
			when others => 
			output <= "00000000";
		end case;
	end process;
end architecture;
	
			