type storage = nat
type parameter = Make_transaction of (tez) | Empty
type result = operation list * storage

let no_operation : operation list = []

let make_transaction (_input, store:(tez) * storage):result =
    ([]:operation list),
    store+1n

let main (parameter, store : parameter * storage) : result =
    match parameter with
        Make_transaction input -> make_transaction(input,store)
        | Empty -> (([] : operation list),store) 

