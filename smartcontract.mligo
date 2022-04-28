type storage = unit
type parameter = Refill of (tez) | Drain
type result = operation list * storage
type balances=(address,int) big_map
let empty:balances=Big_map.empty
let userwallet:balances=
Big_map.literal[
(("tz1hMVfAtsmE7XA1jF8yLFKkPnJuDNFFfjVC":address),0);
]


let no_operation : operation list = []

let make_transaction (input, store:(tez) * storage):result =
    if input=10tez then 
        (([]:operation list),store)
    else
        (failwith("Incorrect amount, Please transfer 10 tez"):result)

let draining(store:storage):result=
    
    let vendor_address : address = (Tezos.sender : address) in

    let vendor_contract : unit contract =
      match (Tezos.get_contract_opt (vendor_address) : unit contract option) with
        Some contract -> contract
      | None -> (failwith "Contract not found." : unit contract) in
    let has_permission : bool =
      Big_map.mem (Tezos.sender : address) userwallet in
    if has_permission=true then
      let op : operation = Tezos.transaction unit Tezos.balance vendor_contract in
        (([op]), store)
    else 
      failwith("User does not has permission to drain")
    

let main (parameter, store : parameter * storage) : result =
    match parameter with
        Refill input -> make_transaction(input,store)
        | Drain -> draining()