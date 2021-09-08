type NumberValidator = (val: number) => boolean

export function validate64 ({ allowNaN = false } = {}): NumberValidator {
  return val => isNaN(val) ? allowNaN : (val >= 0 && val <= 63)
}
