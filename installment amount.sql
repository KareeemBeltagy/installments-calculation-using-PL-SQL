create or replace function installment_amount ( v_CONTRACT_ID     NUMBER )
return number 

is 
no_ofinstallments number(4);  v_net_contract number (8); v_installment number (8);

begin 

no_ofinstallments := calc_no_of_installments(v_CONTRACT_ID);
v_net_contract := net_contract_fees ( v_CONTRACT_ID);

v_installment := v_net_contract/ no_ofinstallments;

return v_installment;
end;