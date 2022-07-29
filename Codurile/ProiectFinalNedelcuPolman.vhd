library IEEE;
use IEEE.std_logic_1164.all;


entity ceva is
  port(
       CLK : in STD_LOGIC;
       Reset : in STD_LOGIC;
       start : in STD_LOGIC;
       Anod : out STD_LOGIC_VECTOR(3 downto 0);
       Catod : out STD_LOGIC_VECTOR(7 downto 0)
  );
end ceva;

architecture ceva of ceva is

component alu
  port (
       clock : in STD_LOGIC;
       enable : in STD_LOGIC := '0';
       flag_c : in STD_LOGIC := '0';
       flag_z : in STD_LOGIC := '0';
       op1 : in STD_LOGIC_VECTOR(7 downto 0);
       op2 : in STD_LOGIC_VECTOR(7 downto 0);
       selector : in STD_LOGIC_VECTOR(7 downto 0);
       res : out STD_LOGIC_VECTOR(7 downto 0) := "00000000";
       ret_flag_c : out STD_LOGIC := '0';
       ret_flag_z : out STD_LOGIC := '0'
  );
end component;
component Carry_Zerro_flags
  port (
       c_in : in STD_LOGIC;
       clock : in STD_LOGIC := '0';
       enable : in STD_LOGIC := '0';
       z_in : in STD_LOGIC;
       c_out : out STD_LOGIC := '0';
       z_out : out STD_LOGIC := '0'
  );
end component;
component decoder_clock
  port (
       intrare : in STD_LOGIC_VECTOR(2 downto 0);
       output : out STD_LOGIC_VECTOR(7 downto 0) := "00000000"
  );
end component;
component display
  port (
       avg : in STD_LOGIC_VECTOR(7 downto 0) := "11101110";
       clk : in STD_LOGIC;
       nr : in STD_LOGIC_VECTOR(7 downto 0);
       anod : out STD_LOGIC_VECTOR(3 downto 0) := "0000";
       catod : out STD_LOGIC_VECTOR(7 downto 0) := "00000000"
  );
end component;
component instructiondecoder
  port (
       CLK : in STD_LOGIC;
       Instructiune : in STD_LOGIC_VECTOR(15 downto 0);
       enable : in STD_LOGIC := '0';
       KK : out STD_LOGIC_VECTOR(7 downto 0) := "00000000";
       SELMUX : out STD_LOGIC := '0';
       SX : out STD_LOGIC_VECTOR(3 downto 0) := "0000";
       SY : out STD_LOGIC_VECTOR(3 downto 0) := "0000";
       SelectorALU : out STD_LOGIC_VECTOR(7 downto 0) := "11111111";
       SelectorJMP : out STD_LOGIC_VECTOR(3 downto 0) := "1111";
       WriteAdress : out STD_LOGIC_VECTOR(3 downto 0) := "0000"
  );
end component;
component Monostabil
  port (
       Buton : in STD_LOGIC;
       Clk : in STD_LOGIC;
       ButonMono : out STD_LOGIC
  );
end component;
component mux_alu
  port (
       a : in STD_LOGIC_VECTOR(7 downto 0);
       b : in STD_LOGIC_VECTOR(7 downto 0);
       selector : in STD_LOGIC;
       o : out STD_LOGIC_VECTOR(7 downto 0) := "00000000"
  );
end component;
component numarator_binar
  port (
       clock : in STD_LOGIC;
       start : in STD_LOGIC;
       valoare : out STD_LOGIC_VECTOR(2 downto 0) := "000"
  );
end component;
component Program_counter
  port (
       clock : in STD_LOGIC;
       enable : in STD_LOGIC := '0';
       flag_citire : in STD_LOGIC;
       new_adress : in STD_LOGIC_VECTOR(7 downto 0);
       reset : in STD_LOGIC;
       adress : out STD_LOGIC_VECTOR(7 downto 0) := "00000000"
  );
end component;
component Program_flow_control
  port (
       carry : in STD_LOGIC;
       clock : in STD_LOGIC;
       constant_data : in STD_LOGIC_VECTOR(7 downto 0);
       enable : in STD_LOGIC := '0';
       operation : in STD_LOGIC_VECTOR(3 downto 0);
       zerro : in STD_LOGIC;
       adresa_noua : out STD_LOGIC_VECTOR(7 downto 0) := "00000000";
       flag_citire : out STD_LOGIC := '0'
  );
end component;
component Program_rom
  port (
       adress : in STD_LOGIC_VECTOR(7 downto 0) := "00000000";
       clock : in STD_LOGIC;
       enable : in STD_LOGIC;
       instruction : out STD_LOGIC_VECTOR(15 downto 0) := "1111111111111111"
  );
end component;
component registers
  port (
       ad1 : in STD_LOGIC_VECTOR(3 downto 0);
       ad2 : in STD_LOGIC_VECTOR(3 downto 0);
       clock : in STD_LOGIC;
       enable : in STD_LOGIC;
       reset : in STD_LOGIC;
       sel_adresa : in STD_LOGIC_VECTOR(3 downto 0);
       we : in STD_LOGIC;
       write : in STD_LOGIC_VECTOR(7 downto 0);
       reg_1 : out STD_LOGIC_VECTOR(7 downto 0) := "00000000";
       reg_2 : out STD_LOGIC_VECTOR(7 downto 0) := "00000000"
  );
end component;

signal NET102 : STD_LOGIC;
signal NET12653 : STD_LOGIC;
signal NET136 : STD_LOGIC;
signal NET13608 : STD_LOGIC;
signal NET138 : STD_LOGIC;
signal NET144 : STD_LOGIC;
signal NET151 : STD_LOGIC;
signal NET177 : STD_LOGIC;
signal semnal_reset : STD_LOGIC;
signal BUS104 : STD_LOGIC_VECTOR (7 downto 0);
signal BUS108 : STD_LOGIC_VECTOR (7 downto 0);
signal BUS112 : STD_LOGIC_VECTOR (7 downto 0);
signal BUS114 : STD_LOGIC_VECTOR (7 downto 0);
signal BUS117 : STD_LOGIC_VECTOR (3 downto 0);
signal BUS120 : STD_LOGIC_VECTOR (3 downto 0);
signal BUS124 : STD_LOGIC_VECTOR (3 downto 0);
signal BUS13417 : STD_LOGIC_VECTOR (7 downto 0);
signal BUS13425 : STD_LOGIC_VECTOR (7 downto 0);
signal BUS170 : STD_LOGIC_VECTOR (3 downto 0);
signal BUS175 : STD_LOGIC_VECTOR (7 downto 0);
signal BUS325 : STD_LOGIC_VECTOR (2 downto 0);
signal BUS7613 : STD_LOGIC_VECTOR (7 downto 0);
signal BUS98 : STD_LOGIC_VECTOR (15 downto 0);
signal st : STD_LOGIC_VECTOR (7 downto 0);

begin

U1 : instructiondecoder
  port map(
       CLK => clk,
       Instructiune => BUS98,
       KK => BUS7613,
       SELMUX => NET102,
       SX => BUS117,
       SY => BUS120,
       SelectorALU => BUS114,
       SelectorJMP => BUS170,
       WriteAdress => BUS124,
       enable => st(1)
  );

NET12653 <= st(4) or st(2);

U11 : Monostabil
  port map(
       Buton => Reset,
       ButonMono => semnal_reset,
       Clk => CLK
  );

U12 : Monostabil
  port map(
       Buton => start,
       ButonMono => NET13608,
       Clk => CLK
  );

U13 : decoder_clock
  port map(
       intrare => BUS325,
       output => st
  );

U14 : numarator_binar
  port map(
       clock => CLK,
       start => NET13608,
       valoare => BUS325
  );

U2 : alu
  port map(
       clock => clk,
       enable => st(3),
       flag_c => NET144,
       flag_z => NET151,
       op1 => BUS112,
       op2 => BUS108,
       res => BUS13417,
       ret_flag_c => NET136,
       ret_flag_z => NET138,
       selector => BUS114
  );

U3 : Carry_Zerro_flags
  port map(
       c_in => NET136,
       c_out => NET144,
       clock => clk,
       enable => st(4),
       z_in => NET138,
       z_out => NET151
  );

U4 : registers
  port map(
       ad1 => BUS117,
       ad2 => BUS120,
       clock => clk,
       enable => NET12653,
       reg_1 => BUS112,
       reg_2 => BUS104,
       reset => semnal_reset,
       sel_adresa => BUS124,
       we => st(4),
       write => BUS13417
  );

U5 : Program_rom
  port map(
       adress => BUS13425,
       clock => clk,
       enable => st(0),
       instruction => BUS98
  );

U6 : mux_alu
  port map(
       a => BUS104,
       b => BUS7613,
       o => BUS108,
       selector => NET102
  );

U7 : Program_flow_control
  port map(
       adresa_noua => BUS175,
       carry => NET144,
       clock => clk,
       constant_data => BUS7613,
       enable => st(5),
       flag_citire => NET177,
       operation => BUS170,
       zerro => NET151
  );

U8 : Program_counter
  port map(
       adress => BUS13425,
       clock => clk,
       enable => st(6),
       flag_citire => NET177,
       new_adress => BUS175,
       reset => semnal_reset
  );

U9 : display
  port map(
       anod => Anod,
       avg => BUS13425,
       catod => Catod,
       clk => clk,
       nr => BUS13417
  );


end ceva;
