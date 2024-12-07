--Esse também tá incompleto, na v24 é pedido que sejá feito uma Ula de 64bits (baseado no que foi feito no P3E1, isso é igual) 
--mas eles querem uma Ula com especificamente 64bits enquanto antes era pedido uma ULA com parametros genéricos (o que teoricamente é mais dificil) 
--Vou deixar aqui a com 64 bits para seguir de exemplo

library ieee;
use ieee.numeric_bit.all;

entity alu is
    generic (
        size : natural := 10
    );
    port (
        A, B : in bit_vector(size - 1 downto 0);
        F : out bit_vector(size - 1 downto 0);
        S : in bit_vector(3 downto 0);
        Z : out bit;
        Ov : out bit;
        Co : out bit
    );
end entity alu;

architecture ALU_arch of alu is
    component alu1bit is
        port (
            a, b, less, cin : in bit;
            result, cout, set, overflow : out bit;
            ainvert, binvert : in bit;
            operation : in bit_vector(1 downto 0)
        );
    end component;

    signal less_interno : bit;
    signal v_saidas, v_sets, v_carries : bit_vector(size - 1 downto 0);

begin
    -- ULA de 1 bit mais significativa
    alu_ms : alu1bit port map(
        A(size - 1), 
        B(size - 1), 
        '0', 
        v_carries(size - 2), 
        v_saidas(size - 1),
        v_carries(size - 1), 
        v_sets(size - 1), 
        Ov, 
        S(3), 
        S(2), 
        S(1 downto 0)
    );

    -- ULAs do meio
    ULA_GERADOR : for i in 1 to (size - 2) generate
        alu_x : alu1bit port map(
            A(i), 
            B(i), 
            '0', 
            v_carries(i - 1), 
            v_saidas(i), 
            v_carries(i), 
            v_sets(i), 
            open, 
            S(3), 
            S(2), 
            S(1 downto 0)
        );
    end generate;

    -- ULA de 1 bit menos significativa
    alu_ls : alu1bit port map(
        A(0), 
        B(0), 
        less_interno, 
        S(2), 
        v_saidas(0), 
        v_carries(0), 
        v_sets(0), 
        open,
        S(3), 
        S(2), 
        S(1 downto 0)
    );

    -- Definição de sinais
    less_interno <= v_sets(size - 1);
    Co <= v_carries(size - 1);
    Z <= '1' when (signed(v_saidas) = 0) else '0';
    F <= v_saidas;

end architecture ALU_arch;
