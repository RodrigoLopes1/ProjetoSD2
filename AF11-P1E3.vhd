library IEEE;
use ieee.numeric_bit.all;
use std.textio.all;

entity rom_arquivo_generica is
    generic (
        addressSize : natural := 5;
        wordSize : natural := 8;
        datFileName : string := "conteudo_rom_af11_p1e2_carga . dat"
    );
    port (
        addr : in bit_vector(addressSize - 1 downto 0);
        data : out bit_vector(wordSize - 1 downto 0)
    );
end rom_arquivo_generica;

architecture part_3 of rom_arquivo_generica is
    type memory_t is array(0 to 2**addressSize - 1) of bit_vector(wordSize - 1 downto 0);

    impure function init_memory(dat_file_name : in string) return memory_t is
        file arquivo : text open read_mode is dat_file_name;
        variable date_line : line;
        variable temp_bv : bit_vector(wordSize - 1 downto 0);
        variable temp_m : memory_t;
    begin
        for i in memory_t'range loop
            readline(arquivo, date_line);
            read(date_line, temp_bv);
            temp_m(i) := temp_bv;
        end loop;
        return temp_m;
    end init_memory;

    signal memoria : memory_t := init_memory(datFileName);

begin
    data <= memoria(to_integer(unsigned(addr)));
end part_3;
