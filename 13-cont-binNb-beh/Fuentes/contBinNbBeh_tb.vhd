library IEEE;
	use IEEE.std_logic_1164.all;

	-- Respecto del ejercicio 13, para el test bench solo hace falta agregar y mapear la constante N

entity contBinNbBeh_tb is
end entity;

architecture contBinNbBeh_tb_arq of contBinNbBeh_tb is
	-- Parte declarativa
	component contBinNbBeh is
		generic (
			N : natural
		);
		port (
			clk_i    : in  std_logic;
			rst_i    : in  std_logic;
			ena_i    : in  std_logic;
			cuenta_o : out std_logic_vector(N - 1 downto 0)
		);
	end component;

	constant N_tb : natural := 8;
	signal clk_tb    : std_logic := '0';
	signal rst_tb    : std_logic := '1';
	signal ena_tb    : std_logic := '0';
	signal cuenta_tb : std_logic_vector(N_tb - 1 downto 0);

begin
	-- Parte descriptiva
	-- La cuenta aumenta monotónicamente
	clk_tb <= not clk_tb after 10 ns;
	-- La habilitación se detiene a la mitad de la cuenta y el DUT debe retener su valor
	ena_tb <= '1' after 30 ns, '0' after 200 ns, '1' after 250 ns;
	-- Sobre el final de la simulación se resetea el contador
	rst_tb <= '0' after 50 ns, '1' after 500 ns;

	DUT: contBinNbBeh
		generic map (
			N => N_tb
		)
		port map (
			clk_i    => clk_tb,
			rst_i    => rst_tb,
			ena_i    => ena_tb,
			cuenta_o => cuenta_tb
		);
end architecture;


