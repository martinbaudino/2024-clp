library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;

	-- 13. Crear en VHDL un contador binario genérico de N bits como el ejercicio 12,
	--  pero describiéndolo por comportamiento. Simular.

entity contBinNbBeh is
	generic (
		N : natural := 8
	);

	port (
		clk_i    : in  std_logic;
		rst_i    : in  std_logic;
		ena_i    : in  std_logic;
		cuenta_o : out std_logic_vector(N - 1 downto 0)
	);
end entity;

architecture contBinNbBeh_arq of contBinNbBeh is
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
		cuenta_o <= std_logic_vector(to_unsigned(cuenta, N));
	end process;
end architecture;


