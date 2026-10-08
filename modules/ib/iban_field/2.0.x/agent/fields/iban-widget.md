# IBAN field widget

`iban_field` is a **field widget only** — it does not define a field type or a formatter. Add a core
**Text (plain)** field (field type `string`) to any entity, then set its form-display widget to
**IBAN Field**. Output on display uses the underlying `string` field's normal formatter.

## Enable the widget on a field

- **UI**: on the bundle's *Manage form display*, set the `string` field's widget to **IBAN Field**.
- **Drush** (point an existing `string` field's form display at the widget):

```bash
drush cset core.entity_form_display.node.supplier.default \
  content.field_bank_account.type iban_field -y
drush cset core.entity_form_display.node.supplier.default \
  content.field_bank_account.settings.placeholder 'NL91ABNA0417164300' -y
drush cset core.entity_form_display.node.supplier.default \
  content.field_bank_account.settings.size 40 -y
drush cr
```

## Widget settings

| Setting | Type | Default | Effect |
|---|---|---|---|
| `size` | integer | 60 | `#size` (visible width) of the textfield. Required, min 1. |
| `placeholder` | label | `''` | `#placeholder` hint shown until a value is entered. |

Declared in `config/schema/iban_field.schema.yml` under `field.widget.settings.iban_field`, so they
export with the form display. `#maxlength` is taken from the field's own `max_length` setting, not
from a widget setting. Defaults and the form come from `IbanFieldWidget::defaultSettings()` /
`settingsForm()`; `settingsSummary()` shows "Textfield size: N" and (when set) "Placeholder: …".

## How validation works

`IbanFieldWidget::formElement()` renders a `textfield` and attaches
`#element_validate = [[IbanFieldWidget::class, 'validateIbanElement']]`.

`validateIbanElement()` (static):

1. Empty input → stored as `''` (empty is allowed; add `#required` on the field to force a value).
2. Otherwise validates with Symfony's constraint:
   ```php
   $violations = Validation::createValidator()->validate($value, [new Iban()]);
   ```
   The Symfony `Iban` constraint checks the two-letter country prefix, the country-specific length,
   and the ISO 7064 mod-97 checksum.
3. Any violation → `$form_state->setError()` with "This is not a valid International Bank Account
   Number (IBAN)." and the value is rejected.
4. Valid → the value is uppercased with `mb_strtoupper()` before it is written.

Because validation is wired into the **widget's form element**, it only runs on entity form
submissions. Values set programmatically, or via REST/JSON:API/migrations, bypass it — enforce IBAN
validity yourself (e.g. an entity-level constraint) on those paths if you need storage-layer
guarantees.

## Config schema

`config/schema/iban_field.schema.yml`:

```yaml
field.widget.settings.iban_field:
  type: mapping
  label: 'IBAN Field widget settings'
  mapping:
    size:
      type: integer
      label: 'Size of textfield'
    placeholder:
      type: label
      label: 'Placeholder'
```

No standalone config object and no settings route (`configure` is null).
