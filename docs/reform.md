## Using ReSchema with ReForm
`ReForm` + `ReSchema` is a powerful combination. Both `ReForm` and `ReSchema` are libraries that leverage the powerful ReScript type system and you can combine
these libraries to build type-safe forms.
In the next section we'll cover a basic usage of ReSchema with ReForm.
> If you don't know, we recommend checking the [official documentation](https://reform.rescriptbrasil.org) first.

## Setting up ReForm
You can install ReForm by following the installation instructions [here](https://reform.rescriptbrasil.org/docs/installation).

## Creating the form instance
First off, you need to create a state model using `lenses-ppx`:
```rescript
module Lenses = %lenses(
  type state = {
    name: string,
    email: string,
    age: int,
  }
)
```
Now, you can create a form instance using `ReForm.Make`:
```
module Lenses = %lenses(
  type state = {
    name: string,
    email: string,
    age: int,
  }
)

module MyForm = ReForm.Make(Lenses)

```
You don't need to use the `ReSchema.Make` functor, because ReForm uses ReSchema as an internal dependency and create the custom schema module.
Now that we have the custom form module, we can use the form hook and pass a custom schema to our form:
```rescript
module Lenses = %lenses(
  type state = {
    name: string,
    email: string,
    age: int,
  }
)

module MyForm = ReForm.Make(Lenses)

let initialState: Lenses.state = {
  name: "",
  email: "",
  age: 0,
}

let useMyForm = () => {
  let handleSubmit = ({state}: MyForm.onSubmitAPI) => {
    Js.log2("Values =>", state.values)
    None
  }

  let form = MyForm.use(
    ~initialState,
    ~onSubmit=handleSubmit,
    ~schema={
      open MyForm.Validation

      Schema(string(~min=3, Name) + int(~min=18, Age))
    },
    (),
  )

  form
}
```
You can see more about ReForm and its api on the [official documentation](https://reform.rescriptbrasil.org).
