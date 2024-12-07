library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_64bit_tb is
end entity;

architecture behavioral of alu_64bit_tb is
    component alu_64bit is
        -- ... (declaração dos ports da ULA)
    end component;

    -- Sinais para a ULA
    signal A, B : bit_vector(63 downto 0);
    signal S : std_logic_vector(3 downto 0);
    signal F : std_logic_vector(63 downto 0);
    signal Z, Ov, Co : std_logic;
    signal clk : std_logic := '0';

begin
    -- Instanciação da ULA
    uut: alu_64bit port map (
        A => A,
        B => B,
        S => S,
        F => F,
        Z => Z,
        Ov => Ov,
        Co => Co
    );

    -- Processo do clock
    clk_process: process
    begin
        while True loop
            clk <= '0';
            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;
        end loop;
    end process;

    -- Processo de estímulo
    stim_process: process
    begin
        -- Aplicar reset (se necessário)
        -- ...

        -- Testes de adição
        A <= x"0000000000000001";
        B <= x"0000000000000001";
        S <= "0000"; -- Código para adição
        wait for 20 ns;
        assert F = x"0000000000000002" report "Erro na adição";
        -- ... outros testes de adição

        -- Testes de subtração
        -- ...

        -- Testes de outras operações
        -- ...

        wait;
    end process;
end behavioral;
