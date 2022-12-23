// From https://github.com/jquense/yup/blob/92668947dafc2bb60bb7565c53b39091a6213167/src/string.ts#L22

let email =  Js.Re.fromString(
  "/^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/"
)
