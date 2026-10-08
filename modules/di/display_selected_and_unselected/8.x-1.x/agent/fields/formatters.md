<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Formatters & theming

## Install & enable

```bash
composer require drupal/display_selected_and_unselected
drush en display_selected_and_unselected -y
```

Core-only, no dependencies, no submodules, no permissions, no Drush commands, no config to import.

## The two formatters

Both live in `src/Plugin/Field/FieldFormatter/` and extend `FormatterBase`. Both apply to
`field_types = { list_string, list_integer, list_float }` and neither has any settings
(their `defaultSettings()`, `settingsForm()`, `settingsSummary()` are empty stubs).

| Plugin id | Class | Label | Renders |
|---|---|---|---|
| `display_selected_and_unselected_values` | `DisplaySelectedAndUnselectedValuesFieldFormatter` | "Display selected and unselected values" | each option's **label (value)** |
| `display_selected_and_unselected_keys` | `DisplaySelectedAndUnselectedKeysFieldFormatter` | "Display selected and unselected keys" | each option's **key** |

The two classes are identical except for the theme-hook prefix (`_values_` vs `_keys_`) and,
in the templates, whether the loop prints `{{ value }}` or `{{ key }}`.

## Enable it on a field

UI: *Structure → (content type) → Manage display* → set a List field's format to
**"Display selected and unselected values"** or **"…keys"** → Save.

Config equivalent (view display):

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_options.type display_selected_and_unselected_values -y
drush cr
```

## Radio vs checkbox rule

`viewElements()` inspects the field **storage cardinality**
(`getFieldStorageDefinition()->getCardinality()`):

- cardinality `== 1` → `#theme => '..._radio'` (disabled `<input type="radio">`).
- any other cardinality (incl. unlimited) → `#theme => '..._checkbox'` (disabled `<input type="checkbox">`).

It reads the allowed options from
`fieldDefinition->getItemDefinition()->getSettings()['allowed_values']`, collects the stored
item `->value`s into `$selected_keys`, and passes `allowed_values`, `selected_keys`, and the
field machine name (`field_name`) to the theme hook. Every allowed option is rendered; an option
is `checked` when its key is in `selected_keys`. All inputs are `disabled` — this is a read-only
display, not an editable widget.

## Theme hooks & template overrides

`hook_theme()` in `display_selected_and_unselected.module` registers four hooks, each with
variables `allowed_values`, `selected_keys`, `field_name`:

- `display_selected_and_unselected_values_checkbox`
- `display_selected_and_unselected_values_radio`
- `display_selected_and_unselected_keys_checkbox`
- `display_selected_and_unselected_keys_radio`

Default templates are in the module's `templates/` dir
(e.g. `display-selected-and-unselected-values-checkbox.html.twig`). Each wraps the list in a
`<div class="display_selected_and_unselected_{values|keys}_{checkbox|radio}">` and loops
`allowed_values` (`{% for key, value in allowed_values %}`). Copy any template into your theme
to customize markup; target the wrapper classes for CSS. Twig auto-escaping applies to the
printed key/value/field-name.
