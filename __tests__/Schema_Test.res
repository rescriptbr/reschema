open! Jest

module Lenses = %lenses(type state = {name: string})

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
