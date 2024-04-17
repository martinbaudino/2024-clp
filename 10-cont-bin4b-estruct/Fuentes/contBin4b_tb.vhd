library IEEE;
	use IEEE.std_logic_1164.all;

entity contBin4b_tb is
end entity;

architecture contBin4b_tb_arq of contBin4b_tb is
	-- Parte declarativa
	component contBin4b is
		port (
			clk_i    : in  std_logic;
			rst_i    : in  std_logic;
			ena_i    : in  std_logic;
			cuenta_o : out std_logic_vector(3 downto 0)
		);
	end component;

	signal clk_tb    : std_logic := '0';
	signal rst_tb    : std_logic := '1';
	signal ena_tb    : std_logic := '0';
	signal cuenta_tb : std_logic_vector(3 downto 0);

begin
	-- Parte descriptiva
	-- La cuenta aumenta monotónicamente
	clk_tb <= not clk_tb after 10 ns;
	-- La habilitación se detiene a la mitad de la cuenta y el DUT debe retener su valor
	ena_tb <= '1' after 30 ns, '0' after 200 ns, '1' after 250 ns;
	-- Sobre el final de la simulación se resetea el contador
	rst_tb <= '0' after 50 ns, '1' after 500 ns;

	DUT: contBin4b
		port map (
			clk_i    => clk_tb,
			rst_i    => rst_tb,
			ena_i    => ena_tb,
			cuenta_o => cuenta_tb
		);
end architecture;


