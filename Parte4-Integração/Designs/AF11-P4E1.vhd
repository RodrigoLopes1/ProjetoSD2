--Essa oficialmente é a parte principal, todo resto além disso é opcional, mas tentar implementar tudo de uma vez é bem pior (btw da pra entregar as outras partes então pode ser bom
--entregar pra sla chorar uns pontinhos) 
--
--Basicamente o objetivo dessa parte é juntar todo que está feito e rodar em uma testbench, na teoria é simples (e de fato é) mas tem que fazer de fato..rs





--A parte 1 da entrega é só fazer um protótipo do fluxo de dados do processador, interligando o banco de registradores e a ULA para executar as instruções do tipo R
--Nessa parte já seria necessario fazer uma testbench pra ver se está tudo ok, e por mais que não tenha que entregar a testbench, tem que fazer de qualquer forma porque tem que entregar 
--Os graficos no gtkwave. 

--Vou deixar a entidade do fluxo de dados que deve ser utilizada (mas não ta pronto!!!!) 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- 
-- Agrupamento da ULA e Banco de Registradores
--

entity ULARegs is
    port (
        y    : out std_logic_vector(63 downto 0); -- saída da ULA
        op   : in std_logic_vector(3 downto 0);  -- operação a realizar
        zero : out std_logic;                    -- indica o resultado zero
        Rd   : in std_logic_vector(4 downto 0);  -- índice do registrador a escrever
        Rm   : in std_logic_vector(4 downto 0);  -- índice do registrador 1 (ler)
        Rn   : in std_logic_vector(4 downto 0);  -- índice do registrador 2 (ler)
        we   : in std_logic;                     -- habilitação de escrita
        clk  : in std_logic                      -- sinal de clock
    );
end entity;
