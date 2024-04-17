library IEEE;
	use IEEE.std_logic_1164.all;

entity contBCD_Lento_tb is
end entity;

architecture contBCD_Lento_tb_arq of contBCD_Lento_tb is

	signal clk_tb    : std_logic := '0';
	signal rst_tb    : std_logic := '1';
	signal ena_tb    : std_logic := '1';
	signal cuenta_orig_tb : std_logic_vector(3 downto 0);
	signal co_orig_tb     : std_logic;

begin

	clk_tb <= not clk_tb after 4 ns;
	rst_tb <= '0' after 10 ns, '1' after 610 ns;
	ena_tb <= '0' after 150 ns, '1' after 160 ns;

	-- Declarar el DUT de esta manera evita tener que incluir los compoenentes manualmente
	DUT_orig: entity work.contBCD_Lento
		generic map (
			-- Esta asignación es la que genera el pulso de enable periódico
			N => 6
		)
		port map (
			clk_i    => clk_tb,
			rst_i    => rst_tb,
			ena_i    => ena_tb,
			cuenta_o => cuenta_orig_tb,
			co_o     => co_orig_tb
		);

end architecture;
