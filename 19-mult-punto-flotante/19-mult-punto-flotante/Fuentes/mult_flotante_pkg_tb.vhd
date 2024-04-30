library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;
	-- Paquete con funciones de conversión. Para poder utilizarlo en las simulaciones es
	-- necesario pasar el argumento "--std=08" a GHDL
	use IEEE.float_pkg.all;

	use work.tipo_punto_flotante_pkg.all;
	use work.mult_flotante_pkg.all;

entity mult_flotante_pkg_tb is
end entity;

architecture mult_flotante_pkg_tb_arq of mult_flotante_pkg_tb is

	signal clk_tb      : std_logic := '0';
	signal rst_tb      : std_logic := '1';
	signal ena_tb      : std_logic := '1';
	signal flotante1   : std_logic_vector(msb_completo downto 0);
	signal flotante2   : std_logic_vector(msb_completo downto 0);
	signal f1, f2, f3  : float32;
	signal resultado32 : std_logic_vector(msb_completo downto 0);
	signal sig         : std_logic;
	signal exp         : std_logic_vector(msb_exponente downto 0);
	signal man         : std_logic_vector(msb_mantisa downto 0);
	signal man_expandida: unsigned(tam_mantisa * 2 + 1 downto 0);

	signal instancia_mult_flot : registro_multiplicador_flotante;

begin

	clk_tb <= not clk_tb after 4 ns;
	rst_tb <= '0' after 140 ns, '1' after 520 ns;
	ena_tb <= '1' after 150 ns, '0' after 510 ns;
	f1     <= to_float(+ 25.15) after 150 ns, to_float(+ 1525.15) after 180 ns, to_float(- 105.15) after 210 ns, to_float(+ 0) after 240 ns;
	f2     <= to_float(+ 6.5) after 150 ns, to_float(+ 3.15) after 180 ns, to_float(+ 25.15) after 210 ns, to_float(+ 25.15) after 240 ns;
	-- La señal f3 se utiliza para comprobar que la salida se la misma que el multiplicador
	-- sintetizable.
	f3        <= f1 * f2;
	flotante1 <= to_std_logic_vector(f1);
	flotante2 <= to_std_logic_vector(f2);

	-- instancia_mult_flot <= ini_multiplicador_flotante;
	-- v1_punto_flotante   <= todos_ceros;
	-- v2_punto_flotante   <= todos_ceros;

	corrida: process (clk_tb)
		variable v1_punto_flotante : registro_flotante;
		variable v2_punto_flotante : registro_flotante;
	begin
		if (ena_tb) then
			--v1_punto_flotante.signo := flotante1(msb_completo);
			--v1_punto_flotante.exponente := signed(flotante1(msb_completo - 1 downto tam_mantisa));
			--v1_punto_flotante.mantisa := unsigned(flotante1(msb_mantisa downto 0));
			v1_punto_flotante := to_punto_flotante(flotante1);
			v2_punto_flotante := to_punto_flotante(flotante2);

			--v2_punto_flotante.signo := flotante2(msb_completo);
			--v2_punto_flotante.exponente := signed(flotante2(msb_completo - 1 downto tam_mantisa));
			--v2_punto_flotante.mantisa := unsigned(flotante2(msb_mantisa downto 0));

			if (rising_edge(clk_tb)) then
				if (rst_tb = '1') then
					resultado32 <= (others => '0');
				else
					crear_mult_flotante(instancia_mult_flot);

					request_float_multiplier(instancia_mult_flot, v1_punto_flotante, v2_punto_flotante);

					if float_multiplier_is_ready(instancia_mult_flot) then
						resultado32 <= get_multiplier_resultado(instancia_mult_flot);
						sig <= instancia_mult_flot.resultado.signo;
						exp <= std_logic_vector(instancia_mult_flot.resultado.exponente);
						man <= std_logic_vector(instancia_mult_flot.resultado.mantisa);
						man_expandida <= instancia_mult_flot.result_mult_mantisa;
					end if;
				end if;
			end if;
		end if;

	end process;

end architecture;
