type storage = unit
type parameter = unit
type result = operation list * storage

let no_operation : operation list = []

let main (_parameter, store : parameter * storage) : result =
    (no_operation, store)