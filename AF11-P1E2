library IEEE;
use IEEE.numeric_bit.all;
use std.textio.all;

entity rom_arquivo is
    port (
        addr : in bit_vector(4 downto 0);
        data : out bit_vector(7 downto 0)
    );
end rom_arquivo;

architecture part_2 of rom_arquivo is
    type memory_t is array (0 to 2**5 - 1) of bit_vector(7 downto 0);

    impure function inicializa(nome_do_arquivo : in string) return memory_t is
        file arquivo : text open read_mode is nome_do_arquivo;
        variable linha : line;
        variable temporary_bv : bit_vector(7 downto 0);
        variable temporary_memory : memory_t;
    begin
        for i in memory_t'range loop
            readline(arquivo, linha);
            read(linha, temporary_bv);
            temporary_memory(i) := temporary_bv;
        end loop;
        return temporary_memory;
    end inicializa;

    signal memoria : memory_t := inicializa("conteudo_rom_ativ_02_carga.dat");

begin
    data <= memoria(to_integer(unsigned(addr)));
end part_2;
