type storage = 
{
    balance:tez;
    counter:nat
}
type parameter = Refill of (tez) | Drain
type result = operation list * storage

let no_operation : operation list = []

let make_transaction (input, store:(tez) * storage):result =
    if input=10tez then 
        (([]:operation list),{store with balance=store.balance+input;counter=store.counter+1n})
    else
        (failwith("Incorrect amount, Please transfer 10 tez"):result)

let draining():result=
    (failwith("Draining~"):result)

let main (parameter, store : parameter * storage) : result =
    match parameter with
        Refill input -> make_transaction(input,store)
        | Drain -> draining()