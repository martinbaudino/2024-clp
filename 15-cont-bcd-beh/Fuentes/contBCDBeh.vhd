library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;

	-- 15. Crear en VHDL un contador BCD de un dígito por comportamiento (describiendo cómo
	-- funciona, utilizando un process). Simularlo.

entity contBCDBeh is
	port (
		clk_i    : in  std_logic;
		rst_i    : in  std_logic;
		ena_i    : in  std_logic;
		cuenta_o : out std_logic_vector(3 downto 0);
		co_o     : out std_logic
	);
end entity;

architecture contBCDBeh_arq of contBCDBeh is
	-- Parte delcarativa

begin
	-- Parte descriptiva
	process (clk_i, rst_i, ena_i)
		variable cuenta : integer := 0;
		variable carry : std_logic := '0';

	begin
		if rising_edge(clk_i) then
			if rst_i = '1' then
				cuenta := 0;
				carry := '0';
			elsif ena_i = '1' then				
				if cuenta = 9 then
					cuenta := 0;
					carry := '1';
				else
				    cuenta := cuenta + 1;
				    carry := '0';
				end if;
			end if;
		end if;

		-- Al transformar el valor en unsiged se acota el tamaño a la cantidad de bits.
		cuenta_o <= std_logic_vector(to_unsigned(cuenta, 4));
		co_o <= carry;
	end process;
end architecture;


