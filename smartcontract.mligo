type storage = nat
type parameter = Make_transaction of (tez) | Empty
type result = operation list * storage

let no_operation : operation list = []

let make_transaction (input, store:(tez) * storage):result =
    let _transaction_validate:nat=
    if input=10tez then 
        store+1n
    else
        failwith("Incorrect amount of tez! Please send 10 tez")
    in 
    (([]:operation list),store)

let main (parameter, store : parameter * storage) : result =
    match parameter with
        Make_transaction input -> make_transaction(input,store)
        | Empty -> (([] : operation list),store) 

