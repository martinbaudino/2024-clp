library IEEE;
	use IEEE.std_logic_1164.all;

entity mux_tb is
end entity;

architecture mux_tb_arq of mux_tb is
	-- Parte declarativa
	component mux is
		port (
			a_i   : in  std_logic;
			b_i   : in  std_logic;
			sel_i : in  std_logic;
			sal_o : out std_logic
		);
	end component;

	signal a_tb   : std_logic := '0';
	signal b_tb   : std_logic := '0';
	signal sel_tb : std_logic := '0';
	signal sal_tb : std_logic;

begin
	-- Parte descriptiva
	a_tb   <= not a_tb after 20 ns;
	b_tb   <= not b_tb after 40 ns;
	sel_tb <= not sel_tb after 100 ns;

	DUT: mux
		port map (
			a_i   => a_tb,
			b_i   => b_tb,
			sel_i => sel_tb,
			sal_o => sal_tb
		);
end architecture;


