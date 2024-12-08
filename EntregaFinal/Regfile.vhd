library IEEE;
use ieee.numeric_bit.all;
use ieee.math_real.ceil;
use ieee.math_real.log2;

entity regfile is
  port (
    clock : in bit;
    reset : in bit;
    regWrite : in bit;
    rr1, rr2, wr : in bit_vector(4 downto 0);
    d : in bit_vector(63 downto 0);
    q1, q2 : out bit_vector(63 downto 0)
  );
end entity regfile;

architecture arch_2 of regfile is
  type outputs is array(0 to 31) of bit_vector(63 downto 0);
  signal output : outputs;
begin
  processamento : process(clock, reset)
  begin
    if reset = '1' then
      for i in 0 to 31 loop
        output(i) <= (others => '0');
      end loop;
    elsif rising_edge(clock) then
      if regWrite = '1' then
        output(to_integer(unsigned(wr))) <= d;
      end if;
    end if;
  end process;

  q1 <= output(to_integer(unsigned(rr1)));
  q2 <= output(to_integer(unsigned(rr2)));
end architecture arch_2;
