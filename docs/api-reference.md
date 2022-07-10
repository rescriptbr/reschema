## API

### `ReSchema.Make(...)`
The module functor `ReForm.Make` receives a module type with the following signature:
```rescript
module type Lenses = {
  type field<'a>
  type state
  let set: (state, field<'a>, 'a) => state
  let get: (state, field<'a>) => 'a
}
```

### `fieldState`
```rescript
type fieldState =
  | Valid
  | NestedErrors(array<childFieldError>)
  | Error(string)
```

### `recordValidationState<'a>`
```rescript
type recordValidationState<'a> =
  | Valid
  | Errors(array<('a, string)>)
```

## `Validation`
This is the validation module.

### `type t`
```rescript
type rec t =
    | Email({
        field: Lenses.field<string>, 
        error: option<string>
      }): t
    | NoValidation({field: Lenses.field<'a>}): t
    | StringNonEmpty({
        field: Lenses.field<string>, a
        error: option<string>
      }): t
    | StringRegExp({
        field: Lenses.field<string>, 
        matches: string, 
        error: option<string>
      }): t
    | StringMin({
        field: Lenses.field<string>, 
        min: int, 
        error: option<string>
      }): t
    | StringMax({
        field: Lenses.field<string>, 
        max: int, 
        error: option<string>
      }): t
    | IntMin({
        field: Lenses.field<int>, 
        min: int, 
        error: option<string>
      }): t
    | IntMax({
        field: Lenses.field<int>, 
        max: int, 
        error: option<string>
      }): t
    | FloatMin({
        field: Lenses.field<float>, 
        min: float, 
        error: option<string>
      }): t
    | FloatMax({
        field: Lenses.field<float>, 
        max: float, 
        error: option<string>
      }): t
    | Custom({
        field: Lenses.field<'a>, 
        predicate: Lenses.state => fieldState
      }): t
    | True({
        field: Lenses.field<bool>, 
        error: option<string>
      }): t
    | False({
        field: Lenses.field<bool>, 
        error: option<string>
      }): t
```

### `schema`
```rescript
type schema = array<t>
```

