<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Unlimited or Number" field widget

Class: `Drupal\unlimited_number\Plugin\Field\FieldWidget\UnlimitedNumberWidget`
(plugin id `unlimited_number`, label **"Unlimited or Number"**). It extends core's
`NumberWidget` and applies **only to `integer` fields** (`field_types = {"integer"}`).

It renders the `#type => unlimited_number` element (see
[../api/unlimited_number.md](../api/unlimited_number.md)) on the entity edit form and — this
is the widget's whole point — **converts the "unlimited" choice into a real integer** before
storage, so the field column stays a plain integer.

## Settings

| Setting key | Default | Meaning |
|---|---|---|
| `value_unlimited` | `0` | The integer actually **stored** when the user picks "Unlimited". Set to `-1` for core cardinality convention, or `0`, etc. |
| `label_unlimited` | `Unlimited` | Text of the "unlimited" radio. |
| `label_number` | `Limited` | Text of the "limited" radio. |

Config schema for these lives at `field.widget.settings.unlimited_number` (keys
`value_unlimited`, `label_unlimited`, `label_number`, `placeholder`).

### How unlimited is stored / read back

- On save, `massageFormValues()` replaces the element's `'unlimited'` string with
  `getUnlimitedValue()` — i.e. the `value_unlimited` setting cast to int (empty → `0`).
- On load, `formElement()` compares the stored value to `value_unlimited`; if equal, it
  pre-selects "Unlimited", otherwise it pre-fills the number. `#min`/`#max` come from the
  field's own settings (min defaults to `1` if unset).
- **Caveat:** because "unlimited" is stored as an ordinary integer, a genuine limit that
  happens to equal `value_unlimited` is indistinguishable from "unlimited". Pick a
  `value_unlimited` that can never be a real limit (e.g. `0` or `-1`).

## Assigning the widget (config, no UI of its own)

There is no dedicated admin page; you set it like any widget — on the entity **form display**.

Via Drush/PHP:

```php
$fd = \Drupal::service('entity_display.repository')
  ->getFormDisplay('node', 'article', 'default');
$fd->setComponent('field_my_limit', [
  'type' => 'unlimited_number',
  'settings' => [
    'value_unlimited' => -1,
    'label_unlimited' => 'Unlimited',
    'label_number' => 'Limited',
  ],
])->save();
```

Or in the UI: *Structure → Content types → Manage form display* → set the integer field's
widget to **"Unlimited or Number"** and open the gear to edit the three settings.

In exported config (`core.entity_form_display.node.article.default.yml`):

```yaml
content:
  field_my_limit:
    type: unlimited_number
    settings:
      value_unlimited: -1
      label_unlimited: Unlimited
      label_number: Limited
```

## Notes

- No permissions, no Drush commands, no plugin *types* of its own — it is a single widget
  plugin plus the render element it uses.
- The widget extends `NumberWidget`, so it inherits number-widget behaviour (e.g. placeholder)
  in addition to the three settings above.
