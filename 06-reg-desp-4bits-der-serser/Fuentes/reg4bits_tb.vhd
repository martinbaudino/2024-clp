library IEEE;
	use IEEE.std_logic_1164.all;

entity reg4bits_tb is
end entity;

architecture reg4bits_tb_arq of reg4bits_tb is
	-- Parte declarativa
	component reg4bits is
		port (
			clk_i : in  std_logic;
			rst_i : in  std_logic;
			ena_i : in  std_logic;
			d_i   : in  std_logic;
			q_o   : out std_logic
		);
	end component;

	signal clk_tb : std_logic := '0';
	signal rst_tb : std_logic := '1';
	signal ena_tb : std_logic := '1';
	signal d_tb   : std_logic := '1';
	signal q_tb   : std_logic;

begin
	-- Parte descriptiva
	clk_tb <= not clk_tb after 10 ns;
	rst_tb <= '0' after 10 ns, '1' after 180 ns, '0' after 190 ns;
	d_tb   <= '0' after 30 ns, '1' after 50 ns, '0' after 70 ns, '1' after 90 ns, '1' after 110 ns, '1' after 130 ns, '1' after 150 ns;
	ena_tb <= '1' after 10 ns, '0' after 200 ns;

	DUT: reg4bits
		port map (
			clk_i => clk_tb,
			rst_i => rst_tb,
			ena_i => ena_tb,
			d_i   => d_tb,
			q_o   => q_tb
		);
end architecture;


