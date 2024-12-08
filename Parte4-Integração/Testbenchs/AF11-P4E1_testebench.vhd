library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ULARegs_tb is
    -- Não possui portas porque é apenas um testbench
end ULARegs_tb;

architecture Behavioral of ULARegs_tb is
    -- Componentes e sinais para teste
    component ULARegs is
        port (
            y : out std_logic_vector(63 downto 0);
            zero : out std_logic;
            op : in std_logic_vector(3 downto 0);
            Rd : in std_logic_vector(4 downto 0);
            Rn : in std_logic_vector(4 downto 0);
            Rm : in std_logic_vector(4 downto 0);
            we : in bit;
            clk : in bit
        );
    end component;

    -- Sinais para conectar ao DUT (Device Under Test)
    signal clk : bit := '0';
    signal we : bit := '0';
    signal op : std_logic_vector(3 downto 0) := (others => '0');
    signal Rd, Rn, Rm : std_logic_vector(4 downto 0) := (others => '0');
    signal y : std_logic_vector(63 downto 0);
    signal zero : std_logic;

    -- Constante para clock
    constant clk_period : time := 10 ns;

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
        while true loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Teste principal
    stim_process : process
    begin
        -- Teste 1: Soma R2 + R3 e armazena em R1
        -- Configuração inicial
        Rn <= "00010"; -- Registrador 2
        Rm <= "00011"; -- Registrador 3
        Rd <= "00001"; -- Registrador 1 (resultado)
        op <= "0010";  -- Código da operação de soma
        we <= '1';     -- Habilitar escrita
        wait for clk_period;

        -- Teste 2: Subtração R4 - R5 e armazena em R6
        Rn <= "00100"; -- Registrador 4
        Rm <= "00101"; -- Registrador 5
        Rd <= "00110"; -- Registrador 6 (resultado)
        op <= "0110";  -- Código da operação de subtração
        wait for clk_period;

        -- Teste 3: AND entre R1 e R2, armazenado em R7
        Rn <= "00001"; -- Registrador 1 (resultado da soma anterior)
        Rm <= "00010"; -- Registrador 2
        Rd <= "00111"; -- Registrador 7
        op <= "0000";  -- Código da operação AND
        wait for clk_period;

        -- Teste 4: Verificar zero flag com resultado 0
        Rn <= "00111"; -- Registrador 7
        Rm <= "00111"; -- Registrador 7 (mesmo valor para garantir 0 no resultado)
        Rd <= "01000"; -- Registrador 8
        op <= "0110";  -- Subtração: R7 - R7 = 0
        wait for clk_period;

        -- Finaliza simulação
        wait for 50 ns;
        wait;
    end process;
end Behavioral;
