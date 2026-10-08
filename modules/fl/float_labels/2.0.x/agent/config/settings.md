<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Float Labels — configuration & operation

## Install / enable

- `drush en float_labels -y`. No dependencies (only core jQuery/Drupal assets via the library).
- Nothing happens until you configure which forms to match — the module ships **no** `config/install`
  defaults, so `float_labels.settings` starts empty until the settings form is saved.

## Route, permission, menu

- Route `float_labels.admin_settings` → **`/admin/config/user-interface/float-labels`**
  (`float_labels.routing.yml`), form `\Drupal\float_labels\Form\SettingsForm`.
- Guarded by permission **`administer float labels`** (`float_labels.permissions.yml`).
- Menu link `float_labels.admin_settings` under `system.admin_config_ui`
  (*Configuration → User interface*), `float_labels.links.menu.yml`.

## Config object: `float_labels.settings`

`SettingsForm` (`src/Form/SettingsForm.php`, extends `ConfigFormBase`, `getFormId()` =
`float_labels_admin_settings`, `getEditableConfigNames()` = `['float_labels.settings']`) writes
these keys on submit:

| Key | Type | Form field | Meaning |
| --- | --- | --- | --- |
| `included_forms` | string (textarea) | *Forms → Included forms* | Form IDs to match, one per line. A line starting with `/` is a regex (passed to `preg_match`); otherwise exact string match against `$form['#form_id']`. |
| `excluded_forms` | string (textarea) | *Forms → Excluded forms* | Form IDs to drop from the matched set (same string/regex rule). Checked only after a form matched `included_forms`. |
| `included_selectors` | string (textarea) | *CSS selectors → Included selectors* | Extra CSS selectors (one per line) added to the JS include set. `*` allowed. |
| `excluded_selectors` | string (textarea) | *CSS selectors → Excluded selectors* | CSS selectors removed from the JS set. |
| `mark_required` | bool (checkbox) | *Options → Mark required fields* | Adds `float-labels-star` class so required fields show a "*". |
| `select_field_default_value` | bool (checkbox) | *Options → Replace default select option with its label* | When on, `select` is added to the processed element types and the empty option's text is replaced. |
| `select_field_default_value_template` | string (textfield) | *Options → Select field default value template* | `sprintf` template where `%s` is the field label; default `' - %s - '`. |

No `config/schema/` is shipped, so these keys are plain untyped config (no typed-data validation,
no translation metadata).

### Example config export

```yaml
# float_labels.settings.yml
included_forms: |
  user_login_form
  /^comment_/
excluded_forms: ''
included_selectors: ''
excluded_selectors: '#edit-mail'
mark_required: true
select_field_default_value: false
select_field_default_value_template: ' - %s - '
```

## How matching flows to the page (`float_labels.module`)

1. `hook_element_info_alter()` appends `float_labels_process_element` to `#process` for the
   text-like element types (and `select` if `select_field_default_value` is set).
2. `float_labels_process_element($element, $form_state)` reads the complete form; if
   `#float_labels` is set on the element or form it uses that boolean directly, otherwise it calls
   `float_labels_should_process_form($form)`.
3. On include it adds `float-labels-include`/`float-labels-exclude` (or the `*-children` variant on
   the `form` element itself) to `#attributes[class]`, handles selects via
   `float_labels_select()`, and calls `float_labels_attach()`.
4. `float_labels_attach()` sets
   `#attached[drupalSettings][float_labels] = {includes, excludes, mark_required}` and
   `#attached[library][] = 'float_labels/float_labels'`.

`float_labels_should_process_form()` splits `included_forms`/`excluded_forms` on newlines; a line
beginning with `/` → `preg_match($line, $form_id)`, else `$line == $form_id`.

## Per-form override (for custom modules)

Set `$form['#float_labels'] = TRUE;` (or `FALSE`) in a `hook_form_alter()`, or `#float_labels` on
an individual element, to force include/exclude without editing global config. `TRUE` → include,
any non-null falsey value → exclude (`float-labels-exclude`).

## Front-end behavior (`js/float_labels.js`)

`Drupal.behaviors.floatLabels.attach()` reads `settings.float_labels`, gathers
`.float-labels-include` plus `:input:text, textarea` inside `.float-labels-include-children`
(minus buttons, selects, and already-processed items), then unions/subtracts the `includes` /
`excludes` selector lists. For each field it: wraps it in `<div class="float-labels-wrapper">`
(adding `float-labels-required` when the field is `required`, and `float-labels-star` when
`mark_required` is on), inserts a `<label class="float-labels-label" for=…>` carrying the original
label text (the source `<label>` is removed), strips the `placeholder`, and adds
`float-labels-processed`. Focus/blur/change handlers toggle `float-labels-focused` on the wrapper
(also when the field has a value), which drives the CSS3 label animation in `css/float_labels.css`.

## Select handling (`float_labels_select()`)

Only runs when `select_field_default_value` is enabled. It builds
`t(sprintf($template, $title))` from the field `#title` (unwrapping `TranslatableMarkup` via
`getUntranslatedString()`), then either prepends that label at the element's `#empty_value` key or
overwrites the existing `_none` option. Select fields are not floated by the JS (they are excluded
from wrapping); this option instead makes the empty option read like the label.

## Operating notes

- Styling is intentionally minimal — override/extend `css/float_labels.css` in your theme.
- The library is attached only to forms that match, so unrelated pages carry no extra JS/CSS.
- Accessibility: the JS keeps a real associated `<label for=…>` (it does not rely on the
  `placeholder` attribute), which is the intended benefit over placeholder-only designs.
