library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regfile_tb is
end entity;

architecture behavioral of regfile_tb is
  -- Component declaration for the Unit Under Test (UUT)
  component regfile is
    port (
      clock : in bit;
      reset : in bit;
      regWrite : in bit;
      rr1, rr2, wr : in bit_vector(4 downto 0);
      d : in bit_vector(63 downto 0);
      q1, q2 : out bit_vector(63 downto 0)
    );
  end component;

  -- Signal declarations
  signal clk : bit := '0';
  signal rst : bit := '0';
  signal reg_write : bit := '0';
  signal addr1, addr2, wr_addr : bit_vector(4 downto 0);
  signal data_in : bit_vector(63 downto 0);
  signal data_out1, data_out2 : bit_vector(63 downto 0);

begin
  -- Instantiate the UUT
  uut: regfile
    port map (
      clock => clk,
      reset => rst,
      regWrite => reg_write,
      rr1 => addr1,
      rr2 => addr2,
      wr => wr_addr,
      d => data_in,
      q1 => data_out1,
      q2 => data_out2
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

    -- Test case 1: Write to register 0 and read from register 0
    wr_addr <= "00000";
    data_in <= x"0001_0002_0003_0004";
    reg_write <= '1';
    wait for 20 ns;
    reg_write <= '0';
    addr1 <= "00000";
    addr2 <= "00000";
    wait for 20 ns;
    assert data_out1 = x"0001_0002_0003_0004" report "Error: Incorrect read from register 0";
    assert data_out2 = x"0001_0002_0003_0004" report "Error: Incorrect read from register 0";

    -- ... Add more test cases ...

    wait;
  end process;
end behavioral;
