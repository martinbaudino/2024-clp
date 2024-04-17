library IEEE;
	use IEEE.std_logic_1164.all;

	-- El test bench es como el del ejercicio 11, solo cambia el nombre del DUT

entity contBCD4dig_tb is
end entity;

architecture contBCD4dig_tb_arq of contBCD4dig_tb is
	-- Parte declarativa
	component contBCD4dig is
		port (
			clk_i  : in  std_logic;
			rst_i  : in  std_logic;
			ena_i  : in  std_logic;
			co_o   : out std_logic;
			bcd0_o : out std_logic_vector(3 downto 0);
			bcd1_o : out std_logic_vector(3 downto 0);
			bcd2_o : out std_logic_vector(3 downto 0);
			bcd3_o : out std_logic_vector(3 downto 0)
		);
	end component;

	signal clk_tb     : std_logic := '0';
	signal rst_tb     : std_logic := '1';
	signal ena_tb     : std_logic := '0';
	signal carry_tb   : std_logic;
	signal cuenta0_tb : std_logic_vector(3 downto 0);
	signal cuenta1_tb : std_logic_vector(3 downto 0);
	signal cuenta2_tb : std_logic_vector(3 downto 0);
	signal cuenta3_tb : std_logic_vector(3 downto 0);

begin
	-- Parte descriptiva
	-- La cuenta aumenta monotónicamente
	clk_tb <= not clk_tb after 2 ns;
	-- La habilitación se detiene a la mitad de la cuenta y el DUT debe retener su valor
	ena_tb <= '1' after 30 ns, '0' after 200 ns, '1' after 250 ns;
	-- Sobre el final de la simulación se resetea el contador
	-- Para simular toda la cuenta se debe dejar correr la simulación el tiempo suficiente
	rst_tb <= '0' after 50 ns, '1' after 45000 ns;

	DUT: contBCD4dig
		port map (
			clk_i  => clk_tb,
			rst_i  => rst_tb,
			ena_i  => ena_tb,
			co_o   => carry_tb,
			bcd0_o => cuenta0_tb,
			bcd1_o => cuenta1_tb,
			bcd2_o => cuenta2_tb,
			bcd3_o => cuenta3_tb

		);
end architecture;


