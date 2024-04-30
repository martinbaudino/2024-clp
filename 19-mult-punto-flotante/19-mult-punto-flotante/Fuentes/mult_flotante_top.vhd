library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;

	use work.tipo_punto_flotante_pkg.all;
	use work.mult_flotante_pkg.all;

	-- 19. Trabajo Práctico Final: Multiplicador de Punto Flotante

entity mult_flotante_top is
	port (
		clk_i       : in  std_logic;
		rst_i       : in  std_logic;
		iniciar_i   : in  std_logic;
		op1_i       : in  std_logic_vector(msb_completo downto 0);
		op2_i       : in  std_logic_vector(msb_completo downto 0);
		resultado_o : out std_logic_vector(msb_completo downto 0);
		listo_o     : out std_logic
	);
end entity;

architecture mult_flotante_top_arq of mult_flotante_top is
	signal instancia_mult_flot : registro_multiplicador_flotante;
begin
	process (clk_i, rst_i, iniciar_i, op1_i, op2_i)
		-- Variables para valores de entradas
		-- Variables para valores de operaciones
		variable op1_flotante, op2_flotante : registro_flotante := todos_ceros;

	begin
		op1_flotante := to_punto_flotante(op1_i);
		op2_flotante := to_punto_flotante(op2_i);

		if (rising_edge(clk_i)) then
			if (rst_i = '1') then
				resultado_o <= (others => '0');
				listo_o <= '0';
			else
				if iniciar_i = '0' then
					listo_o <= '0';
				else

					crear_mult_flotante(instancia_mult_flot);

					request_float_multiplier(instancia_mult_flot, op1_flotante, op2_flotante);

					if float_multiplier_is_ready(instancia_mult_flot) then
						listo_o <= '1';
						resultado_o <= get_multiplier_resultado(instancia_mult_flot);
					else
						listo_o <= '0';
					end if;
				end if;
			end if;
		end if;
	end process;

end architecture;
