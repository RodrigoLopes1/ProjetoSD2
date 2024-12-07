library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_tb is
end entity;

architecture behavioral of reg_tb is
  -- Component declaration for the Unit Under Test (UUT)
  component reg is
    generic (
      wordSize : natural := 4
    );
    port (
      clock : in bit;
      reset : in bit;
      load : in bit;
      d : in bit_vector(wordSize - 1 downto 0);
      q : out bit_vector(wordSize - 1 downto 0)
    );
  end component;

  -- Signal declarations
  signal clk : bit := '0';
  signal rst : bit := '0';
  signal ld : bit := '0';
  signal din : bit_vector(3 downto 0) := "0000";
  signal qout : bit_vector(3 downto 0);

begin
  -- Instantiate the UUT
  uut: reg generic map (wordSize => 4)
       port map (
         clock => clk,
         reset => rst,
         load => ld,
         d => din,
         q => qout
       );

  -- Clock generation process with limited cycles
  clk_process: process
    variable cycle_count : integer := 0;
  begin
    while cycle_count < 100 loop -- Adjust the cycle limit as needed
      clk <= '0';
      wait for 10 ns;
      clk <= '1';
      wait for 10 ns;
      cycle_count := cycle_count + 1;
    end loop;
    -- Force termination after 100 cycles
    wait;
  end process;

  -- Testbench stimulus process
 stim_process: process
  begin
    -- Apply reset
    rst <= '1';
    wait for 20 ns;
    rst <= '0';
    wait for 20 ns;

    -- Load different values and assert the expected output
    ld <= '1';
    din <= "0001";
    wait for 20 ns;
    ld <= '0';
    assert qout = "0001" report "Erro: Valor de saída incorreto após carregar 0001" severity error;
    wait for 20 ns;

    -- Load another value and assert the expected output
    ld <= '1';
    din <= "1010";
    wait for 20 ns;
    ld <= '0';
    assert qout = "1010" report "Erro: Valor de saída incorreto após carregar 1010" severity error;
    wait for 20 ns;

    -- ... Add more test cases as needed ...

    wait;
  end process;
end behavioral;
