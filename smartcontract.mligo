type storage = nat
type parameter = Refill of (tez) | Drain
type result = operation list * storage

let no_operation : operation list = []

let make_transaction (input, store:(tez) * storage):result =
    if input=10tez then 
        (([]:operation list),store+1n)
    else
        (failwith("Incorrect amount, Please transfer 10 tez"):result)

let draining(store:storage):result=
    let contract_add : address = ("KT1KJUgWMo8UEvqDhBtLMc2M42XJNgfJRttQ": address) in
    
    let vendor_contract : unit contract =
      match (Tezos.get_contract_opt (contract_add) : unit contract option) with
        Some contract -> contract
      | None -> (failwith "Contract not found." : unit contract) in
    
    let op : operation = Tezos.transaction unit 10tez vendor_contract in
    ([op], store)


let main (parameter, store : parameter * storage) : result =
    match parameter with
        Refill input -> make_transaction(input,store)
        | Drain -> draining(store)