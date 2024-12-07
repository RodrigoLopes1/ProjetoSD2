library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ULARegs is
    port (
        y : out std_logic_vector(63 downto 0); -- Saída da ULA
        zero : out std_logic; -- Indicação resultado zero

        -- Entradas de controle
        op : in std_logic_vector(3 downto 0); -- Operação a realizar
        Rd : in std_logic_vector(4 downto 0); -- Índice do registrador a escrever
        Rn : in std_logic_vector(4 downto 0); -- Índice do registrador 2 (ler)
        Rm : in std_logic_vector(4 downto 0); -- Índice do registrador 1 (ler)
        we : in std_logic; -- Habilitação de escrita
        clk : in std_logic -- Sinal de clock
    );
end ULARegs;

architecture Behavioral of ULARegs is
    -- Sinais internos para interconexão
    signal reg_out1, reg_out2 : std_logic_vector(63 downto 0); -- Saídas do banco de registradores
    signal alu_result : std_logic_vector(63 downto 0); -- Resultado da ULA
    signal alu_zero : std_logic; -- Sinal zero da ULA
begin
    -- Instância do banco de registradores
    regfile_inst : entity work.regfile
        port map (
            clock => clk,
            reset => '0', -- Assumindo que não há reset externo
            regWrite => we,
            rr1 => Rn,
            rr2 => Rm,
            wr => Rd,
            d => alu_result,
            q1 => reg_out1,
            q2 => reg_out2
        );

    -- Instância da ULA
    alu_inst : entity work.alu
        generic map (
            size => 64
        )
        port map (
            A => reg_out1,
            B => reg_out2,
            F => alu_result,
            S => op,
            Z => alu_zero,
            Ov => open, -- Overflow não utilizado
            Co => open  -- Carry-out não utilizado
        );

    -- Saídas
    y <= alu_result;
    zero <= alu_zero;

end Behavioral;
