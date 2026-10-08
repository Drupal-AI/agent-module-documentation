# Button Formatter site settings

Form `Drupal\button_formatter\Form\ButtonFormatterSettings` (`ConfigFormBase`), route
`button_formatter.settings` at **`/admin/config/button-formatter`** (menu link under
*Configuration → User interface*), gated by permission `administer button formatter`.
It edits the single config object **`button_formatter.settings`**.

This form defines the *vocabulary* of button classes the site offers; the per-field-display
formatter ([../fields/formatter.md](../fields/formatter.md)) then picks from it. Because the choice
lives in the display config, it exports with `drush cex` and applies everywhere the display renders.

## Config object `button_formatter.settings`

| Key | Form field | Meaning |
|---|---|---|
| `global_class` | Global Class (textfield) | Class added to every button (install default `btn`). |
| `styles` | Styles (textarea) | One `class\|Label` per line; the `class` is the CSS class, `Label` is the select option label shown on the formatter. |
| `sizes` | Sizes (textarea) | One `class\|Label` per line. Stored, but the current formatter does not render a size (see note). |
| `radius` | Radius (textarea) | One `class\|Label` per line. Stored, but the current formatter does not render a radius (see note). |

`external_link` is also *read* by the formatter's `getClass()` (as the external-URL class) but is
**not** written by this form and is absent from the install defaults, so it is effectively an
optional/undeclared key that falls back to the literal `external-link`.

### Install defaults (`config/install/button_formatter.settings.yml`)
`global_class: btn`; `styles` = Bootstrap `btn-primary|Primary … btn-dark|Dark`;
`sizes` = `sm|Small … xl|Extra Large`; `radius` = `rounded-0|None … rounded-circle|Circle`.
The module ships preconfigured for Bootstrap and is meant to be re-pointed at any CSS framework.

### Validation / submit
`validateForm()` splits each textarea on newlines and errors (`Invalid format for button styles`
/ `… sizes` / `… radius`) if any non-blank line does not split into exactly two `|`-separated
parts. `submitForm()` strips `\r`, explodes on `PHP_EOL`, and saves each list.

### Set it with Drush / PHP
```php
$config = \Drupal::configFactory()->getEditable('button_formatter.settings');
$config->set('global_class', 'btn');
$config->set('styles', ['btn-primary|Primary', 'btn-outline-primary|Outline']);
$config->save();
```
Or `drush cset button_formatter.settings global_class btn -y`.

## Config schema note
`config/schema/button_formatter.schema.yml` declares only
`field.formatter.settings.button_formatter` (the per-display formatter settings). There is **no**
schema entry for the `button_formatter.settings` config object itself.
