library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

	-- 20240424 - MSB - Definición de tipo de dato para operaciones de punto flotante

package tipo_punto_flotante_pkg is
	-- Ancho de bits de la mantisa
	constant tam_mantisa : integer := 23;
	-- Ancho de bits del exponente
	constant tam_exponente : integer := 8;

	-- Posición del bit más significativo  de cada parte
	constant msb_mantisa   : integer := tam_mantisa - 1;
	constant msb_exponente : integer := tam_exponente - 1;
	constant msb_completo  : integer := 1 + msb_exponente + msb_mantisa + 1;

	-- Tipos de dato que componen un número de punto flotante
	subtype t_mantisa is unsigned(msb_mantisa downto 0);
	subtype t_exponente is signed(msb_exponente downto 0);

	type registro_flotante is record
		signo     : std_logic;
		exponente : t_exponente;
		mantisa   : t_mantisa;
	end record;

	function ini_flotante(
		signo     : std_logic;
		exponente : integer range - 2 ** t_exponente'high to 2 ** t_exponente'high - 1;
		mantisa   : t_mantisa
	) return registro_flotante;

	type arreglo_flotante is array (natural range <>) of registro_flotante;

	constant todos_ceros : registro_flotante := ('0',(others => '0'),(others => '0'));
	constant max_pos     : registro_flotante := ('0',(msb_exponente => '0', others => '1'),(others => '1'));

	-- Interfaces del paquete. Las funciones permiten ocultar los detalles de implementación en el acceso a los datos.
	function get_mantisa_signo(obj_flotante : registro_flotante)
		return signed;

	function get_exponente(num_flotante : registro_flotante)
		return integer;

	function get_mantisa(num_flotante : registro_flotante)
		return integer;

	function get_signo(num_flotante : registro_flotante)
		return std_logic;

	function to_punto_flotante(valor_flotante_bits : std_logic_vector)
		return registro_flotante;

end package;

-- Implementación de las funciones del paquete

package body tipo_punto_flotante_pkg is

	-- Inicialización del tipo de datos registro_flotante
	function ini_flotante(
			signo     : std_logic;
			exponente : integer range - 2 ** t_exponente'high to 2 ** t_exponente'high - 1;
			mantisa   : t_mantisa
		) return registro_flotante is
	begin
		return (
			signo     => signo,
			-- El exponente se convierte a "signed" del tamaño correspoindiente con el operador "'length"
			exponente => to_signed(exponente, t_exponente'length),
			mantisa   => mantisa
		);
	end function;

	-- Obtención de la mantisa con signo
	function get_mantisa_signo(
			obj_flotante : registro_flotante
		) return signed is
		-- Extiende el tamaño mantisa para que contenga el signo 
		variable mantisa_con_signo : signed(tam_mantisa downto 0) := (others => '0');

	begin
		mantisa_con_signo(t_mantisa'range) := signed(obj_flotante.mantisa);
		-- Computa la mantisa con signo, dependiendo del signo de registro_flotante
		if obj_flotante.signo = '1' then
			mantisa_con_signo := - mantisa_con_signo;
		end if;

		return mantisa_con_signo;
	end function;

	-- Obtención del exponente como entero
	function get_exponente(num_flotante : registro_flotante)
		return integer is
	begin
		return to_integer(num_flotante.exponente);
	end function;

	-- Obtención de la mantisa como entero
	function get_mantisa(num_flotante : registro_flotante)
		return integer is
	begin
		return to_integer(num_flotante.mantisa);
	end function;

	-- Obtención del bit de signo
	function get_signo(num_flotante : registro_flotante)
		return std_logic is
	begin
		return num_flotante.signo;
	end function;

	function to_punto_flotante(valor_flotante_bits : std_logic_vector)
		return registro_flotante is
		variable valor_punto_flotante: registro_flotante := todos_ceros;
	begin
		valor_punto_flotante.signo := valor_flotante_bits(msb_completo);
		valor_punto_flotante.exponente := signed(valor_flotante_bits(msb_completo - 1 downto tam_mantisa));
		valor_punto_flotante.mantisa := unsigned(valor_flotante_bits(msb_mantisa downto 0));
		return valor_punto_flotante;

	end function;
end package body;
