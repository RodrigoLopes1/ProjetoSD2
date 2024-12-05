library IEEE;
use IEEE.numeric_bit.all;
entity rom_simples is
port (
 addr : in bit_vector(4 downto 0);
 data : out bit_vector(7 downto 0)
 );
 end rom_simples;
 architecture part_1 of rom_simples is
 type memory_t is array(0 to 31) of bit_vector(7 downto 0);
 signal memoria : memory_t;

 begin
	memoria(0) <= "00000000";
	memoria(1) <= "00000011";
	memoria(2) <= "11000000";
	memoria(3) <= "00001100";
	memoria(4) <= "00110000";
	memoria(5) <= "01010101";
	memoria(6) <= "10101010";
	memoria(7) <= "11111111";
  	memoria(8) <= "11100000";
	memoria(9) <= "11100111";
	memoria(10) <= "00000111";
	memoria(11) <= "00011000";
	memoria(12) <= "11000011";
	memoria(13) <= "00111100";
	memoria(14) <= "11110000";
	memoria(15) <= "00001111";
	memoria(16) <= "11101101";
	memoria(17) <= "10001010";
	memoria(18) <= "00100100";
	memoria(19) <= "01010101";
	memoria(20) <= "01001100";
	memoria(21) <= "01000100";
	memoria(22) <= "01110011";
	memoria(23) <= "01011101";
	memoria(24) <= "11100101";
	memoria(25) <= "01111001";
	memoria(26) <= "01010000";
	memoria(27) <= "01000011";
	memoria(28) <= "01010011";
	memoria(29) <= "10110000";
	memoria(30) <= "11011110";
	memoria(31) <= "00110001";
 data <= memoria(to_integer( unsigned(addr)));
end part_1;
