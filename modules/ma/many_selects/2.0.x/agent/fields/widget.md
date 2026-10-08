<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Many Selects field widget

The whole module is one field widget plugin:
`Drupal\many_selects\Plugin\Field\FieldWidget\OptionsManySelectWidget`
(id **`many_options_select`**, label "Many select list"). It extends core's
`OptionsSelectWidget`, so it inherits core's option building and validation and only
changes how a *multi-value* field is presented.

## What it does

Instead of one native `<select multiple>` for the whole field, each field delta is rendered
as its own **single** `<select>`. With a multi-value field (cardinality > 1) core's
multiple-value wrapper then stacks one dropdown per value and adds the usual "Add another
item" AJAX button — so an editor picks values one dropdown at a time rather than ctrl-clicking
inside one list box. No data-model change: it is purely a form-display presentation choice and
switching it on or off is reversible.

Mechanics in `formElement()`:
- `#options` is set to `['_none' => <empty label>] + $this->getOptions($entity)` (the empty
  sentinel plus core's allowed-values options for the field).
- the built element is nested under the field's storage column (`$this->column` — `value` for
  `list_*`, `target_id` for `entity_reference`).
- `#default_value` is `_none` when the delta is empty, otherwise the stored value.
- `#multiple` is forced to `FALSE` (each select holds one value); `#type` is unset on the outer
  element.

`validateElement()`: a `_none` selection is normalised back to `NULL` (empty), and if the field
is required and left at `_none` it raises "@name field is required." — so `_none` never gets
stored as a real value.

## Applicable field types

`entity_reference`, `list_integer`, `list_float`, `list_string`. (Requires core **Options**;
Field UI to select it.)

## Choosing it

Manage form display for the bundle (e.g. `/admin/structure/types/manage/{bundle}/form-display`),
set the field's widget to **"Many select list"**. Or in config, on the
`core.entity_form_display.*` component: `type: many_options_select`.

## Widget setting

One setting, edited via the widget's gear icon on the form-display screen:

| Key | Default | Meaning |
|---|---|---|
| `empty_label` | `- None -` | Text shown for the empty (`_none`) option in each dropdown. |

`settingsSummary()` shows `Empty Label: <value>`. The label is rendered through
`$this->t('@label', ['@label' => …])`, i.e. as an escaped placeholder.

Example form-display component config:

```yaml
field_tags:
  type: many_options_select
  settings:
    empty_label: '- Pick a tag -'
```
