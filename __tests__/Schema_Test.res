open! Jest

module Lenses = {
  type state = {name: string}

  type rec field<_> = Name: field<string>

  let get:
    type value. (state, field<value>) => value =
    (state, field) =>
      switch field {
      | Name => state.name
      }

  let set:
    type value. (state, field<value>, value) => state =
    (_, field, value) =>
      switch field {
      | Name => {name: value}
      }
}

module CustomSchema = ReSchema.Make(Lenses)

describe("Schema", (. ()) => {
  it("validateOne", (. ()) => {
    let schema = {
      open CustomSchema.Validation

      schema([string(~min=12, ~minError="Invalid name.", Name)])
    }

    let result = CustomSchema.validateOne(~field=Field(Name), ~values={name: "Alonzo"}, schema)

    expect(result)->not->toBe(None)

    switch result {
    | None => ()
    | Some((field, error)) => {
        expect(field)->toStrictEqual(Field(Name))->ignore
        expect(error)->toStrictEqual(Error("Invalid name."))->ignore
      }
    }
  })
})
