create or replace function calc_no_of_installments (  v_CONTRACT_ID     NUMBER    )
return number
is
v_CONTRACT_STARTDATE      DATE   ;v_CONTRACT_ENDDATE      DATE ; v_contract_payment_type varchar2(20);
no_of_installment number(8); v_factor number(3);
begin 
    select CONTRACT_STARTDATE , CONTRACT_ENDDATE , contract_payment_type
     into v_CONTRACT_STARTDATE , v_CONTRACT_ENDDATE , v_contract_payment_type
    from contracts where contract_id = v_CONTRACT_ID;
    
    v_factor := case  v_contract_payment_type
        when 'ANNUAL' then 12
        when 'QUARTER' then 3
        when 'HALF_ANNUAL' then 6
        else 1
        end;
    
    no_of_installment := trunc(months_between(v_CONTRACT_ENDDATE,v_CONTRACT_STARTDATE ),0)/v_factor;
    
return no_of_installment;
end;

show errors
