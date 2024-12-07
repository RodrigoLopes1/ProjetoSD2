library ieee;
use ieee.numeric_bit.all;

entity alu_64bit is
  port (
    A, B : in bit_vector(63 downto 0);
    F : out bit_vector(63 downto 0);
    S : in bit_vector(3 downto 0);  -- Código da operação
    Z : out bit;                  -- Flag de zero
    Ov : out bit;                 -- Flag de overflow
    Co : out bit                  -- Carry-out
  );
end entity alu_64bit;

architecture ALU_arch_64bit of alu_64bit is
  component alu1bit is
    port (
      a, b, less, cin : in bit;
      result, cout, set, overflow : out bit;
      ainvert, binvert : in bit;
      operation : in bit_vector(1 downto 0)
    );
  end component;

  signal less_interno : bit;
  signal v_saidas, v_sets, v_carries : bit_vector(63 downto 0);

begin
  -- ULA de 1 bit mais significativa
  alu_ms : alu1bit port map(
    A(63), B(63), '0', v_carries(62), v_saidas(63), v_carries(63), v_sets(63), Ov, S(3), S(2), S(1 downto 0)
  );

  -- ULAs do meio
  ULA_GERADOR : for i in 1 to 62 generate
    alu_x : alu1bit port map(
      A(i), B(i), '0', v_carries(i - 1), v_saidas(i), v_carries(i), v_sets(i), open, S(3), S(2), S(1 downto 0)
    );
  end generate;

  -- ULA de 1 bit menos significativa
  alu_ls : alu1bit port map(
    A(0), B(0), less_interno, S(2), v_saidas(0), v_carries(0), v_sets(0), open, S(3), S(2), S(1 downto 0)
  );

  -- Definição de sinais
  less_interno <= v_sets(63);
  Co <= v_carries(63);
  Z <= '1' when (signed(v_saidas) = 0) else '0';
  F <= v_saidas;

end architecture ALU_arch_64bit;
