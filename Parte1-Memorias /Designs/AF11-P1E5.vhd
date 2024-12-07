-- Implementacao da Memoria de Instrucoes
library ieee;
use ieee.numeric_bit.all;
use std.textio.all;

entity memoriaInstrucoes is 
    generic (
        datFileName : string := "conteudo_memInstr_af11_p1e5_carga.dat"
    );
    port (
        addr : in bit_vector(7 downto 0);
        data : out bit_vector(31 downto 0)
    );
end entity memoriaInstrucoes;

architecture Behavioral of memoriaInstrucoes is
    type memory_array is array (0 to 255) of bit_vector(31 downto 0);
    signal mem : memory_array;
begin
    process
    	file mem_file : text open read_mode is datFileName;
        variable line_content : line;
        variable temp_data : bit_vector(31 downto 0);
    begin
        for i in 0 to 255 loop
            readline(mem_file, line_content);
            read(line_content, temp_data);
            mem(i) <= temp_data;
        end loop;
        wait;
    end process;

    data <= mem(to_integer(unsigned(addr)));

end architecture Behavioral;

-- Implementação da Memoria de Dados
library ieee;
use ieee.numeric_bit.all;
use std.textio.all;

entity memoriaDados is
    generic (
        datFileName : string := "conteudo_memDados_af11_p1e5_carga.dat"
    );
    port (
        clk : in bit;
        wr : in bit;
        addr : in bit_vector(7 downto 0);
        data_i : in bit_vector(63 downto 0);
        data_o : out bit_vector(63 downto 0)
    );
end entity memoriaDados;

architecture Behavioral of memoriaDados is
    type memory_array is array (0 to 255) of bit_vector(63 downto 0);
    signal mem : memory_array;
    signal addr_int : integer;

begin
    process
    	file mem_file : text open read_mode is datFileName;
        variable line_content : line;
        variable temp_data : bit_vector(63 downto 0);
    begin
        for i in 0 to 255 loop
            readline(mem_file, line_content);
            read(line_content, temp_data);
            mem(i) <= temp_data;
        end loop;
        wait;
    end process;

    addr_int <= to_integer(unsigned(addr));

    process(clk)
    begin
        if rising_edge(clk) then
            if wr = '1' then
                mem(addr_int) <= data_i;
            end if;
        end if;
    end process;

    data_o <= mem(addr_int);

end architecture Behavioral;

