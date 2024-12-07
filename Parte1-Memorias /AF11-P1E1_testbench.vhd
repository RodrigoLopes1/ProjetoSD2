library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

entity rom_simples_tb is
end rom_simples_tb;

architecture testbench of rom_simples_tb is
    -- Signal declaration
    signal addr : bit_vector(4 downto 0); 
    signal data : bit_vector(7 downto 0);
    
    -- Component instantiation
    component rom_simples is
        port (
            addr : in bit_vector(4 downto 0); 
            data : out bit_vector(7 downto 0)
        );
    end component;

begin
    -- Instantiate the ROM component
    uut: rom_simples
        port map (
            addr => addr,
            data => data
        );

    stim_proc: process
    begin
        -- Testa todos os enderecos possiveis (0 a 31)
        addr <= "00000"; wait for 10 ns;
        assert (data = "00000000") report "Erro no endereço 0" severity error;
        
        addr <= "00001"; wait for 10 ns;
        assert (data = "00000011") report "Erro no endereço 1" severity error;
        
        addr <= "00010"; wait for 10 ns;
        assert (data = "11000000") report "Erro no endereço 2" severity error;
        
        addr <= "00011"; wait for 10 ns;
        assert (data = "00001100") report "Erro no endereço 3" severity error;
        
        addr <= "00100"; wait for 10 ns;
        assert (data = "00110000") report "Erro no endereço 4" severity error;
        
        addr <= "00101"; wait for 10 ns;
        assert (data = "01010101") report "Erro no endereço 5" severity error;
        
        addr <= "00110"; wait for 10 ns;
        assert (data = "10101010") report "Erro no endereço 6" severity error;
        
        addr <= "00111"; wait for 10 ns;
        assert (data = "11111111") report "Erro no endereço 7" severity error;
        
        addr <= "01000"; wait for 10 ns;
        assert (data = "11100000") report "Erro no endereço 8" severity error;
        
        addr <= "01001"; wait for 10 ns;
        assert (data = "11100111") report "Erro no endereço 9" severity error;
        
        addr <= "01010"; wait for 10 ns;
        assert (data = "00000111") report "Erro no endereço 10" severity error;
        
        addr <= "01011"; wait for 10 ns;
        assert (data = "00011000") report "Erro no endereço 11" severity error;
        
        addr <= "01100"; wait for 10 ns;
        assert (data = "11000011") report "Erro no endereço 12" severity error;
        
        addr <= "01101"; wait for 10 ns;
        assert (data = "00111100") report "Erro no endereço 13" severity error;
        
        addr <= "01110"; wait for 10 ns;
        assert (data = "11110000") report "Erro no endereço 14" severity error;
        
        addr <= "01111"; wait for 10 ns;
        assert (data = "00001111") report "Erro no endereço 15" severity error;
        
        addr <= "10000"; wait for 10 ns;
        assert (data = "11101101") report "Erro no endereço 16" severity error;
        
        addr <= "10001"; wait for 10 ns;
        assert (data = "10001010") report "Erro no endereço 17" severity error;
        
        addr <= "10010"; wait for 10 ns;
        assert (data = "00100100") report "Erro no endereço 18" severity error;
        
        addr <= "10011"; wait for 10 ns;
        assert (data = "01010101") report "Erro no endereço 19" severity error;
        
        addr <= "10100"; wait for 10 ns;
        assert (data = "01001100") report "Erro no endereço 20" severity error;
        
        addr <= "10101"; wait for 10 ns;
        assert (data = "01000100") report "Erro no endereço 21" severity error;
        
        addr <= "10110"; wait for 10 ns;
        assert (data = "01110011") report "Erro no endereço 22" severity error;
        
        addr <= "10111"; wait for 10 ns;
        assert (data = "01011101") report "Erro no endereço 23" severity error;
        
        addr <= "11000"; wait for 10 ns;
        assert (data = "11100101") report "Erro no endereço 24" severity error;
        
        addr <= "11001"; wait for 10 ns;
        assert (data = "01111001") report "Erro no endereço 25" severity error;
        
        addr <= "11010"; wait for 10 ns;
        assert (data = "01010000") report "Erro no endereço 26" severity error;
        
        addr <= "11011"; wait for 10 ns;
        assert (data = "01000011") report "Erro no endereço 27" severity error;
        
        addr <= "11100"; wait for 10 ns;
        assert (data = "01010011") report "Erro no endereço 28" severity error;
        
        addr <= "11101"; wait for 10 ns;
        assert (data = "10110000") report "Erro no endereço 29" severity error;
        
        addr <= "11110"; wait for 10 ns;
        assert (data = "11011110") report "Erro no endereço 30" severity error;
        
        addr <= "11111"; wait for 10 ns;
        assert (data = "00110001") report "Erro no endereço 31" severity error;
        
        -- Fim do teste
        wait;
    end process;
end testbench;
