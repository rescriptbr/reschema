module Lenses = %lenses(
  type state = {
    name: string,
    email: string,
    age: int,
  }
)

module MySchema = ReSchema.Make(Lenses)

let schema = {
  open MySchema.Validation

  Schema([
    StringNonEmpty({
      field: Lenses.Name,
      error: None,
      meta: (),
    }),
    IntMin({
      field: Age,
      min: 18,
      error: None,
      meta: (),
    }),
  ])
}

let result = MySchema.validate({name: "Marcos", email: "", age: 12}, schema)

switch result {
| Valid => Js.log("Valid")
| Errors(errors) => Js.log2("Errors =>", errors)
}
