library IEEE;
	use IEEE.std_logic_1164.all;

	-- El test bench es como el del ejercicio 11, solo cambia el nombre del DUT

entity contBCDBeh_tb is
end entity;

architecture contBCDBeh_tb_arq of contBCDBeh_tb is
	-- Parte declarativa
	component contBCDBeh is
		port (
			clk_i    : in  std_logic;
			rst_i    : in  std_logic;
			ena_i    : in  std_logic;
			cuenta_o : out std_logic_vector(3 downto 0);
			co_o     : out std_logic
		);
	end component;

	signal clk_tb    : std_logic := '0';
	signal rst_tb    : std_logic := '1';
	signal ena_tb    : std_logic := '0';
	signal cuenta_tb : std_logic_vector(3 downto 0);
	signal carry_tb  : std_logic;

begin
	-- Parte descriptiva
	-- La cuenta aumenta monotónicamente
	clk_tb <= not clk_tb after 10 ns;
	-- La habilitación se detiene a la mitad de la cuenta y el DUT debe retener su valor
	ena_tb <= '1' after 30 ns, '0' after 200 ns, '1' after 250 ns;
	-- Sobre el final de la simulación se resetea el contador
	rst_tb <= '0' after 50 ns, '1' after 500 ns;

	DUT: contBCDBeh
		port map (
			clk_i    => clk_tb,
			rst_i    => rst_tb,
			ena_i    => ena_tb,
			cuenta_o => cuenta_tb,
			co_o     => carry_tb
		);
end architecture;


