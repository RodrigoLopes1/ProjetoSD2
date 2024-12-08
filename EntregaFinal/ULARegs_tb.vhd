library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ULARegs_tb is
end ULARegs_tb;

architecture Behavioral of ULARegs_tb is
    -- Componentes e sinais para teste
    component ULARegs is
        port (
            y : out bit_vector(63 downto 0);
            zero : out bit;
            op : in bit_vector(3 downto 0);
            Rd : in bit_vector(4 downto 0);
            Rn : in bit_vector(4 downto 0);
            Rm : in bit_vector(4 downto 0);
            we : in bit;
            clk : in bit
        );
    end component;

    -- Sinais para conectar ao DUT
    signal clk : bit := '0';
    signal we : bit := '0';
    signal op : bit_vector(3 downto 0) := (others => '0');
    signal Rd, Rn, Rm : bit_vector(4 downto 0) := (others => '0');
    signal y : bit_vector(63 downto 0);
    signal zero : bit;

    -- Constante para clock
    constant clk_period : time := 10 ns;

    -- Função de conversão de inteiros para bit_vector
    function to_bit_vector(value : integer; size : integer) return bit_vector is
        variable result : bit_vector(size - 1 downto 0) := (others => '0');
        variable temp : integer := value;
    begin
        for i in 0 to size - 1 loop
            if (temp mod 2) = 1 then
                result(size - 1 - i) := '1';
            end if;
            temp := temp / 2;
        end loop;
        return result;
    end function;

    -- Função para realizar operação "and" entre dois bit_vectors
    function bitwise_and(a, b : bit_vector) return bit_vector is
        variable result : bit_vector(a'range);
    begin
        for i in a'range loop
            result(i) := a(i) and b(i);
        end loop;
        return result;
    end function;

    -- Função para comparar dois bit_vectors
    function equal(a, b : bit_vector) return boolean is
    begin
        return a = b;
    end function;

begin
    -- Instância da entidade testada
    DUT : ULARegs
        port map (
            y => y,
            zero => zero,
            op => op,
            Rd => Rd,
            Rn => Rn,
            Rm => Rm,
            we => we,
            clk => clk
        );

    -- Geração do clock
    clk_process : process
    begin
        while now < 200 ns loop -- Limita a simulação a 200 ns
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
        wait; -- Finaliza o processo
    end process;

    -- Teste principal
    stim_process : process
    begin
        -- Teste 1: Soma R2 + R3 e armazena em R1
        Rn <= "00010"; -- Registrador 2
        Rm <= "00011"; -- Registrador 3
        Rd <= "00001"; -- Registrador 1
        op <= "0010";  -- Operação de soma
        we <= '1';     -- Habilitar escrita
        wait for clk_period;

        -- Verificação
        assert equal(y, to_bit_vector(16#AAAA# + 16#5555#, 64))
        report "Erro no Teste 1: Soma" severity error;

        -- Teste 2: Subtração R4 - R5 e armazena em R6
        Rn <= "00100"; -- Registrador 4
        Rm <= "00101"; -- Registrador 5
        Rd <= "00110"; -- Registrador 6
        op <= "0110";  -- Operação de subtração
        wait for clk_period;

        -- Verificação
        assert equal(y, to_bit_vector(16#3333# - 16#1111#, 64))
        report "Erro no Teste 2: Subtração" severity error;

        -- Teste 3: AND entre R1 e R2, armazenado em R7
        Rn <= "00001"; -- Registrador 1
        Rm <= "00010"; -- Registrador 2
        Rd <= "00111"; -- Registrador 7
        op <= "0000";  -- Operação AND
        wait for clk_period;

        -- Verificação
        assert equal(y, bitwise_and(to_bit_vector(16#AAAA#, 64), to_bit_vector(16#5555#, 64)))
        report "Erro no Teste 3: AND" severity error;

        -- Teste 4: Subtração que resulta em zero
        Rn <= "00111"; -- Registrador 7
        Rm <= "00111"; -- Mesmo valor
        Rd <= "01000"; -- Registrador 8
        op <= "0110";  -- Operação de subtração
        wait for clk_period;

        -- Verificação
        assert equal(y, to_bit_vector(0, 64)) and zero = '1'
        report "Erro no Teste 4: Resultado Zero" severity error;

        -- Finaliza simulação
        report "Simulação concluída com sucesso" severity note;
        wait;
    end process;
end Behavioral;
