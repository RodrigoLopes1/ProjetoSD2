library ieee;
use ieee.numeric_bit.all;

entity ula is
    port(
        A: in bit_vector(63 downto 0);
	B: in bit_vector(63 downto 0);
        S: in bit_vector(3 downto 0);
        F: out bit_vector(63 downto 0);
        Z, Ov, Co: out bit
    );
end entity;

architecture stuctural of ula is

    component ula1bit is
        port(
            a, b, less, cin: in bit;
            result, cout, set, overflow: out bit;
            ainvert, binvert: in bit;
            operation: in bit_vector(1 downto 0)
        );
    end component;

    signal ainvert, binvert: bit;
    signal operation: bit_vector(1 downto 0);
    signal coutBv: bit_vector(62 downto 0);
    signal resultBv, setBv, overflowBv, zero: bit_vector(63 downto 0);

begin

    ainvert <= S(3);
    binvert <= S(2);
    operation <= S(1 downto 0);

    -- Primeira ULA (menos significativa)
    firstUla: ula1bit port map(
        A(0), B(0), '0', binvert,
        resultBv(0), coutBv(0), setBv(0), overflowBv(0),
        ainvert, binvert,
        operation
    );
    zero(0) <= resultBv(0);

    -- Última ULA (mais significativa)
    lastUla: ula1bit port map(
        A(size-1), B(size-1), '0', coutBv(size-2),
        resultBv(size-1), Co, setBv(size-1), Ov,
        ainvert, binvert,
        operation
    );
    zero(size-1) <= zero(size-2) or resultBv(size-1);

    -- ULAs intermediárias
    Ulas: for i in size-2 downto 1 generate
        Ula_i: ula1bit port map(
            A(i), B(i), '0', coutBv(i-1),
            resultBv(i), coutBv(i), setBv(i), overflowBv(i),
            ainvert, binvert,
            operation
        );
        zero(i) <= zero(i-1) or resultBv(i);
    end generate;

    -- Definição das saídas
    Z <= not zero(size-1); -- Flag de zero
    F <= resultBv;         -- Resultado final

end architecture;