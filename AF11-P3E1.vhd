--Importante, o somador utilizado aqui está disponivel no moodle, nos outros anos esse somador era pedido pra ser contruído nos itens da parte 2
--Vou deixar o somador no repositório também. 


library IEEE;

entity ula1bit is
    port (
        a         : in bit;
        b         : in bit;
        less      : in bit; -- Esse não tem na v24 
        cin       : in bit;
        ainvert   : in bit;
        binvert   : in bit;
        operation : in bit_vector(1 downto 0);
        result    : out bit; 
        cout      : out bit; 
        set       : out bit; -- Essa também não ;-;
        overflow  : out bit
        
    );
end entity;

architecture alu of ula1bit is
    component fulladder is
        port (
            a, b, cin : in bit;
            s, cout : out bit
        );
    end component;

    signal a_processado, b_processado : bit;
    signal s_res, s_cout : bit;
    signal and_op, or_op, add_op, slt_op : bit;

begin
    a_processado <= ainvert xor a;
    b_processado <= binvert xor b;

    SOMADOR: fulladder port map(a_processado, b_processado, cin, s_res, s_cout);

    set <= s_res;
    cout <= s_cout;
    overflow <= (a_processado xnor b_processado) and (a_processado xor s_res);

    and_op <= a_processado and b_processado;
    or_op <= a_processado or b_processado;
    slt_op <= less;

    with operation select
        result <= and_op when "00",
                  or_op when "01",
                  s_res when "10",
                  slt_op when "11";
end architecture alu;
