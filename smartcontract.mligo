type storage = unit
type parameter = Make_transaction of (tez) | Empty
type result = operation list * storage

let no_operation : operation list = []



let make_transaction (input, store:(tez) * storage):result =
    (failwith("Transaction Denied"):result)
    


let main (parameter, store : parameter * storage) : result =
    match parameter with
        Make_transaction input -> make_transaction(input,store)
        | Empty -> (([] : operation list),store) 
        