library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity display is
port (
nr1: in std_logic_vector(7 downto 0):="00000000";
nr2: in std_logic_vector(7 downto 0):="00000000";
clk: in std_logic;
anod: out std_logic_vector(3 downto 0):="0000";
catod: out std_logic_vector(7 downto 0):="00000000"
);
end display;

architecture architecture_display of display is
begin
	process(clk , nr1 , nr2 )
	variable clk_div:integer:=0;
	variable digit_index:bit:='0';
	variable part_index:bit:='0';
	variable segments:std_logic_vector(7 downto 0):=("11111111");
	begin
		if(rising_edge(clk)) then
			if (clk_div=4999) then
				clk_div:=0;
			
				if(part_index='0') then	
					if(digit_index='0') then
						anod <= "0111";
					else
						anod <= "1011";
					end if;
				else
					if(digit_index='0') then
						anod <= "1101";
					else
						anod <= "1110";
					end if;
				end if;
				
				if(part_index='0') then
					if(digit_index='0') then
						case nr1(7 downto 4) is
							when "0000" => segments := "00000011"; -- 0
							when "0001" => segments := "10011111"; -- 1
							when "0010" => segments := "00100101"; -- 2
							when "0011" => segments := "00001101"; -- 3
							when "0100" => segments := "10011001"; -- 4
							when "0101" => segments := "01001001"; -- 5
							when "0110" => segments := "01000001"; -- 6   
							when "0111" => segments := "00011111"; -- 7
							when "1000" => segments := "00000001"; -- 8
							when "1001" => segments := "00001001"; -- 9
							when "1010" => segments := "00010001"; -- A
							when "1011" => segments := "11000001"; -- b
							when "1100" => segments := "11100101"; -- c
							when "1101" => segments := "10000101"; -- d
							when "1110" => segments := "01100001"; -- E
							when others => segments := "01110001"; -- F
						end case;		
						catod<=segments;
					else
						case nr1(3 downto 0) is
							when "0000" => segments := "00000011"; -- 0
							when "0001" => segments := "10011111"; -- 1
							when "0010" => segments := "00100101"; -- 2
							when "0011" => segments := "00001101"; -- 3
							when "0100" => segments := "10011001"; -- 4
							when "0101" => segments := "01001001"; -- 5
							when "0110" => segments := "01000001"; -- 6   
							when "0111" => segments := "00011111"; -- 7
							when "1000" => segments := "00000001"; -- 8
							when "1001" => segments := "00001001"; -- 9
							when "1010" => segments := "00010001"; -- A
							when "1011" => segments := "11000001"; -- b
							when "1100" => segments := "11100101"; -- c
							when "1101" => segments := "10000101"; -- d
							when "1110" => segments := "01100001"; -- E
							when others => segments := "01110001"; -- F
							end case;		
							catod<=segments;
					end if;
					digit_index:=not(digit_index);
				
				else 
					if(digit_index='0') then
						case nr2(7 downto 4) is
							when "0000" => segments := "00000011"; -- 0
							when "0001" => segments := "10011111"; -- 1
							when "0010" => segments := "00100101"; -- 2
							when "0011" => segments := "00001101"; -- 3
							when "0100" => segments := "10011001"; -- 4
							when "0101" => segments := "01001001"; -- 5
							when "0110" => segments := "01000001"; -- 6   
							when "0111" => segments := "00011111"; -- 7
							when "1000" => segments := "00000001"; -- 8
							when "1001" => segments := "00001001"; -- 9
							when "1010" => segments := "00010001"; -- A
							when "1011" => segments := "11000001"; -- b
							when "1100" => segments := "11100101"; -- c
							when "1101" => segments := "10000101"; -- d
							when "1110" => segments := "01100001"; -- E
							when others => segments := "01110001"; -- F
						end case;		
						catod<=segments;
					else 
						case nr2(3 downto 0) is
							when "0000" => segments := "00000011"; -- 0
							when "0001" => segments := "10011111"; -- 1
							when "0010" => segments := "00100101"; -- 2
							when "0011" => segments := "00001101"; -- 3
							when "0100" => segments := "10011001"; -- 4
							when "0101" => segments := "01001001"; -- 5
							when "0110" => segments := "01000001"; -- 6   
							when "0111" => segments := "00011111"; -- 7
							when "1000" => segments := "00000001"; -- 8
							when "1001" => segments := "00001001"; -- 9
							when "1010" => segments := "00010001"; -- A
							when "1011" => segments := "11000001"; -- b
							when "1100" => segments := "11100101"; -- c
							when "1101" => segments := "10000101"; -- d
							when "1110" => segments := "01100001"; -- E
							when others => segments := "01110001"; -- F
						end case;		
						catod<=segments;
					end if;
					digit_index:=not(digit_index);
				end if;
				if digit_index='1' then 
					part_index:=not(part_index);
				end if;
					
			else
				
				clk_div:=clk_div+1;
			end if;
		end if;
	end process;
end architecture;