# The `webform_iban_field` element

## Add it to a webform

In the Webform UI: *Add element* -> search "IBAN" -> **Webform IBAN field** (Advanced elements). Or in a
webform's YAML `elements`:

```yaml
account_iban:
  '#type': webform_iban_field
  '#title': 'Your IBAN'
  '#placeholder': 'NL91ABNA0417164300'
  '#required': true
multiple_ibans:
  '#type': webform_iban_field
  '#title': 'Additional IBANs'
  '#multiple': true
```

## Properties

Extends Webform `TextBase`, so it inherits the standard text-element properties. Defaults it adds
(`getDefaultProperties()`): `multiple`, `size`, `minlength`, `maxlength`, `placeholder`. Renders as
`<input type="text" class="... webform-iban-field">`.

## Validation

`Drupal\webform_iban_field\Element\WebformIbanField::validateWebformIbanField()`:

- Reads the submitted value (falls back to `#value` for multiple).
- A literal `'0'` is treated as invalid.
- Otherwise validates with `Symfony\Component\Validator\Constraints\Iban`
  (`Validation::createValidator()->validate($value, [new Iban()])`).
- On any violation, sets a form error: `The value %value for element %name is not a valid IBAN.`
- Validation is server-side; no external service or library is contacted.

## Notes

- No settings form, permissions, or config schema — behaviour is entirely the element + its validator.
- The bundled `webform.webform.webform_iban_field` config is a demo form (one single + one multiple
  IBAN field). Its default access grants `create` to anonymous + authenticated, i.e. it is a public
  example form; treat it as a template and remove/lock it down on production, or build your own webform
  with the element.
