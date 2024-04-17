library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;

	-- 11. Crear en VHDL un contador binario de 4 bits como el anterior,
	-- pero describiéndolo por comportamiento. Simular.

entity contBin4bBeh is
	port (
		clk_i    : in  std_logic;
		rst_i    : in  std_logic;
		ena_i    : in  std_logic;
		cuenta_o : out std_logic_vector(3 downto 0)
	);
end entity;

architecture contBin4bBeh_arq of contBin4bBeh is
	-- Parte delcarativa

begin
	-- Parte descriptiva
	process (clk_i, rst_i, ena_i)
		variable cuenta : integer := 0;

	begin
		if rising_edge(clk_i) then
			if rst_i = '1' then
				cuenta := 0;
			elsif ena_i = '1' then
				cuenta := cuenta + 1;
			end if;
		end if;

		-- Al transformar el valor en unsiged se acota el tamaño a la cantidad de bits.
		cuenta_o <= std_logic_vector(to_unsigned(cuenta, 4));
	end process;
end architecture;


