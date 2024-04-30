library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.numeric_std.all;

	use work.tipo_punto_flotante_pkg.all;

package mult_flotante_pkg is

	-- El bit de signo es empujado a través de un registro de desplazamiento que tiene la misma
	-- longitud que las etapas de la cadena de multiplicadores.
	constant etapas_cadena_multiplicado : natural := 3;

	type registro_multiplicador_flotante is record

		izq                     : registro_flotante;
		der                     : registro_flotante;
		resultado               : registro_flotante;
		signo                   : std_logic;
		exponente               : t_exponente;
		result_mult_mantisa     : unsigned(tam_mantisa * 2 + 1 downto 0);
		registro_desplazamiento : std_logic_vector(etapas_cadena_multiplicado - 1 downto 0);
	end record;

	constant ini_multiplicador_flotante : registro_multiplicador_flotante := (todos_ceros, todos_ceros, todos_ceros, '0',(others => '0'),(others => '0'),(others => '0'));

	procedure crear_mult_flotante(
		signal self : inout registro_multiplicador_flotante);

	procedure request_float_multiplier(
		signal self     : out registro_multiplicador_flotante;
		       izq, der :     registro_flotante);

	function float_multiplier_is_ready(self : registro_multiplicador_flotante)
		return boolean;

	function get_multiplier_resultado(self : registro_multiplicador_flotante)
		return std_logic_vector;

	function "*"(izq, der : registro_flotante)
		return registro_flotante;

	function float_multiplier_is_busy(self : registro_multiplicador_flotante)
		return boolean;

end package;

package body mult_flotante_pkg is

	function "*"(
			izq, der : registro_flotante
		) return registro_flotante is
		variable resultado     : registro_flotante                      := todos_ceros;
		variable raw_resultado : unsigned(msb_mantisa * 2 + 1 downto 0) := (others => '0');
	begin

		resultado.signo := izq.signo xor der.signo;
		resultado.exponente := izq.exponente + der.exponente;
		raw_resultado := izq.mantisa * der.mantisa;
		if raw_resultado(msb_mantisa * 2 + 1) = '1' then
			resultado.mantisa := raw_resultado(msb_mantisa * 2 + 1 downto msb_mantisa + 1);
		else
			resultado.mantisa := raw_resultado(msb_mantisa * 2 downto msb_mantisa);
			resultado.exponente := izq.exponente + der.exponente - 1;
		end if;
		return resultado;

	end function;

	procedure crear_mult_flotante(
			signal self : inout registro_multiplicador_flotante
		) is
	begin

		self.registro_desplazamiento <= self.registro_desplazamiento(self.registro_desplazamiento'left - 1 downto 0) & '0';
		self.signo <= self.izq.signo xor self.der.signo;
		self.exponente <= self.izq.exponente + self.der.exponente - 127;
		-- OJO - Acá falta normalizar el producto de las mantisas
		-- self.result_mult_mantisa <= get_mantisa_signo(self.izq) * get_mantisa_signo(self.der);
		self.result_mult_mantisa <= unsigned('1' & std_logic_vector(self.izq.mantisa)) * unsigned('1' & std_logic_vector(self.der.mantisa));

		-- El resultado de la multiplicación de mantisas debe tener un '1' inicial en el primer lugar a la izquierda del 
		-- punto decimal, esto es, en el bit 46 del producto intermedio. Como se presumen entradas de números normalizados
		-- el primer '1' estará en el bit 
		if self.result_mult_mantisa(tam_mantisa * 2 + 1) = '1' then
			self.resultado <= (
				signo     => self.signo,
				exponente => self.exponente + 1,
				mantisa   => self.result_mult_mantisa(tam_mantisa * 2 downto tam_mantisa + 1)
			);
		else
			self.resultado <= (
				signo     => self.signo,
				exponente => self.exponente,
				mantisa   => self.result_mult_mantisa(msb_mantisa * 2 + 1 downto tam_mantisa)
			);
		end if;

	end procedure;

	procedure request_float_multiplier(
			signal self     : out registro_multiplicador_flotante;
			       izq, der :     registro_flotante
		) is
	begin
		self.registro_desplazamiento(0) <= '1';
		self.izq <= izq;
		self.der <= der;

	end procedure;

	function float_multiplier_is_ready(
			self : registro_multiplicador_flotante
		) return boolean is
	begin
		return self.registro_desplazamiento(self.registro_desplazamiento'left) = '1';
	end function;

	function get_multiplier_resultado(
			self : registro_multiplicador_flotante
		) return std_logic_vector is
	begin
		return self.resultado.signo & std_logic_vector(self.resultado.exponente) & std_logic_vector(self.resultado.mantisa);
	end function;

	function float_multiplier_is_busy(
			self : registro_multiplicador_flotante
		) return boolean is
	begin
		return to_integer(signed(self.registro_desplazamiento)) = 0;
	end function;

end package body;
