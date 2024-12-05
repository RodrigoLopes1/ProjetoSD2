library IEEE;
use ieee.numeric_bit.all;

entity ram is
    generic (
        addressSize : natural := 5;
        wordSize : natural := 8
    );
    port (
        ck : in bit;
        wr : in bit;
        addr : in bit_vector(addressSize - 1 downto 0);
        data_i : in bit_vector(wordSize - 1 downto 0);
        data_o : out bit_vector(wordSize - 1 downto 0)
    );
end ram;

architecture part_4 of ram is
    type memory_t is array(0 to 2**addressSize - 1) of bit_vector(wordSize - 1 downto 0);
    signal memoria : memory_t;
begin
    process(ck, wr, addr)
    begin
        if (ck'event and ck = '1' and wr = '1') then
            memoria(to_integer(unsigned(addr))) <= data_i;
        end if;

        if (wr = '0') then
            data_o <= memoria(to_integer(unsigned(addr)));
        end if;
    end process;
end part_4;
