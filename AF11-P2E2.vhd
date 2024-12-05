--Essa parte não está completa (na real nem está feita) Basicamente no programa desse ano eles pedem para implementar um 
--Banco de registradores que possui 32 registradores com 64 bits seguindo a seguinte entidade: 

entity regfile is
    port(
        clock    : in bit;                         --! entrada de clock
        reset    : in bit;                         --! entrada de reset
        regWrite : in bit;                         --! entrada de carga do registrador wr
        rr1      : in bit_vector(4 downto 0);      --! entrada define registrador 1
        rr2      : in bit_vector(4 downto 0);      --! entrada define registrador 2
        wr       : in bit_vector(4 downto 0);      --! entrada define registrador de escrita
        d        : in bit_vector(63 downto 0);     --! entrada de dado para carga paralela
        q1       : out bit_vector(63 downto 0);    --! saída do registrador rr1
        q2       : out bit_vector(63 downto 0)     --! saída do registrador rr2
    );
end entity regfile;


  --Apesar de não ter esse código oq eu tenho é esse codigo aqui, que é de um componente em VHDL correspondente a um bloco de registradores
  --Ele tem uma formatação diferente e parece ter mais do que a gente precisa, mas está consideravelmente perto. 


  library IEEE;
use ieee.numeric_bit.all;
use ieee.math_real.ceil;
use ieee.math_real.log2;

entity regfile is
    generic (
        regn : natural := 32;
        wordSize : natural := 64
    );
    port (
        clock : in bit;
        reset : in bit;
        regWrite : in bit;
        rr1, rr2, wr : in bit_vector(natural(ceil(log2(real(regn)))) - 1 downto 0);
        d : in bit_vector(wordSize - 1 downto 0);
        q1, q2 : out bit_vector(wordSize - 1 downto 0)
    );
end regfile;

architecture arch_2 of regfile is
    type outputs is array(0 to regn - 1) of bit_vector(wordSize - 1 downto 0);
    signal output : outputs;
begin
    processamento : process(clock, reset)
    begin
        if reset = '1' then
            i_for : FOR i IN 0 to regn - 1 LOOP
                j_for : FOR j IN 0 to wordSize - 1 LOOP
                    output(i)(j) <= '0';
                END LOOP j_for;
            END LOOP i_for;
        elsif clock = '1' and clock'event then
            if regWrite = '1' then
                if to_integer(unsigned(wr)) < regn - 1 then
                    output(to_integer(unsigned(wr))) <= d;
                end if;
            end if;
        end if;
    end process;

    q1 <= output(to_integer(unsigned(rr1))) when to_integer(unsigned(rr1)) < regn - 1 else (others => '0');
    q2 <= output(to_integer(unsigned(rr2))) when to_integer(unsigned(rr2)) < regn - 1 else (others => '0');
end arch_2;
