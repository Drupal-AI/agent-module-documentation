# Webform IBAN Field — agent index

Adds one Webform element, `webform_iban_field`, that collects and server-side-validates an IBAN via
Symfony's `Iban` constraint. Requires `webform` (^6.2). No admin page (`configure` null), no
permissions, no config schema, no Drush.

- **The element, its properties, and how validation works** → [element.md](element.md)

Key facts:
- Element plugin `webform_iban_field` (`src/Plugin/WebformElement/WebformIbanField.php`) extends Webform
  `TextBase`; render element (`src/Element/WebformIbanField.php`) extends core `Textfield`.
- Category: "Advanced elements". Supports `#multiple`, `size`, `minlength`, `maxlength`, `placeholder`.
- Validation: `validateWebformIbanField()` runs the value through
  `Symfony\Component\Validator\Constraints\Iban`; failure (or literal `'0'`) -> form error.
- Ships a demo webform config `webform.webform.webform_iban_field` (single + multiple field).
