## Basic usage

First off, you will need `lenses-ppx` installed, you can do this by following the installation instructions [here](https://github.com/Astrocoders/lenses-ppx).

### Creating the state with lenses-ppx
Before the schema, you need to create the state model using `lenses-ppx`.

```rescript
module Lenses = %lenses(
  type state = {
    name: string,
    email: string,
    age: int,
  }
)
```

The next step is to create a custom schema module and build a simple schema using it:
```rescript
module Lenses = %lenses(
  type state = {
    name: string,
    email: string,
    age: int,
  }
)

// We create a schema module combining ReSchema.Make functor 
// and the Lenses module created by lenses-ppx
module MySchema = ReSchema.Make(Lenses)

let schema = {
  open MySchema.Validation

  schema([
    StringNonEmpty({
      field: Lenses.Name,
      error: None,
    }),
    IntMin({
      field: Age,
      min: 18,
      error: None,
    }),
  ]
}

```
Now, we can use any function of `MySchema` module to validate our state. In this case, we'll use the `validate` function to validate all fields of the state:
```rescript
let myState = { name: "Alonzo Church", email: "alonzo@gmail.com", age: 12 }

let result = MySchema.validate(myState, schema)

switch result {
| Valid => Js.log("Valid")
| Errors(errors) => Js.log2("Errors =>", errors)
}
```
If you run this code in your browser (or Node) the result probably will be something like: `Errors => [ [ { _0: 2 }, 'This value must be greater than or equal to 18' ] ]`
