library IEEE;
	use IEEE.std_logic_1164.all;

	-- Para el test bench solo hace falta cambiar la instancia del DUT del ejercicio 10 y agregarN

entity genEna_tb is
end entity;

architecture genEna_tb_arq of genEna_tb is
	-- Parte declarativa
	component genEna is
		generic (
			-- Cantidad de ciclos de reloj entre pulsos generados
			N : natural
		);
		port (
			clk_i : in  std_logic;
			rst_i : in  std_logic;
			ena_i : in  std_logic;
			q_o   : out std_logic
		);
	end component;

	signal N_tb   : natural   := 4;
	signal clk_tb : std_logic := '0';
	signal rst_tb : std_logic := '1';
	signal ena_tb : std_logic := '0';
	signal q_tb   : std_logic;

begin
	-- Parte descriptiva
	-- La cuenta aumenta monotónicamente
	clk_tb <= not clk_tb after 10 ns;
	-- La habilitación se detiene a la mitad de la cuenta y el DUT debe mantener el estado
	ena_tb <= '1' after 30 ns, '0' after 200 ns, '1' after 250 ns;
	-- Sobre el final de la simulación se resetea el contador
	rst_tb <= '0' after 50 ns, '1' after 500 ns;

	DUT: genEna
		generic map (
			N => N_tb
		)
		port map (
			clk_i => clk_tb,
			rst_i => rst_tb,
			ena_i => ena_tb,
			q_o   => q_tb
		);
end architecture;

