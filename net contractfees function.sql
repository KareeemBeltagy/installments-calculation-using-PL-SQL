create or replace function net_contract_fees (  v_CONTRACT_ID     NUMBER    )
return number
is
v_CONTRACT_TOTAL_FEES number(10,2) ; v_CONTRACT_DEPOSIT_FEES number(10,2) ;
v_net_contract_fees number(10,2);
begin 

select CONTRACT_TOTAL_FEES , nvl(CONTRACT_DEPOSIT_FEES,0)   into v_CONTRACT_TOTAL_FEES , v_CONTRACT_DEPOSIT_FEES 
from contracts where CONTRACT_ID =  v_CONTRACT_ID;

v_net_contract_fees := v_CONTRACT_TOTAL_FEES - v_CONTRACT_DEPOSIT_FEES;

return v_net_contract_fees;
end ;

