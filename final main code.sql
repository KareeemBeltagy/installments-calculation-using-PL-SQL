--client contracts
--- installments_paid 
declare 
cursor cur_contract is                                                                                         -- cursor to load required parametres
select  CONTRACT_ID , contract_payment_type , contract_startdate from contracts where CONTRACT_ID=106;

v_counter number(8) default 1 ;
v_factor number(3);
v_payment_type VARCHAR2(20); 
v_installment_date varchar2(30);
begin 

for cur_contract_rec in  cur_contract loop                                                                   --cursor for loop to loop over contract id column.


v_factor := case  cur_contract_rec.contract_payment_type
        when 'ANNUAL' then 12
        when 'QUARTER' then 3
        when 'HALF_ANNUAL' then 6
        else 1
        end;

v_installment_date :=  cur_contract_rec.contract_startdate;
v_counter :=1;                                                                                                    --reset the counter
while v_counter <= calc_no_of_installments(cur_contract_rec.contract_id) loop           -- while loop for insert statment loop for number of instalments

insert into installments_paid ( installment_id , contract_id , installment_date , installment_amount , paid)
values (installmentID_seq.NEXTVAL , cur_contract_rec.contract_id , v_installment_date , installment_amount(cur_contract_rec.CONTRACT_ID) , 0 );

v_installment_date := add_months(cur_contract_rec.contract_startdate, v_factor);




v_counter :=v_counter+1;
end loop;                                                                                                           -- end of while loop


end loop;                                                                                                           -- end of cursor loop 

end ;

show errors;