<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `count` field formatter

`Drupal\field_count_formatter\Plugin\Field\FieldFormatter\Count`
(id `count`, label "Field count") — a plain `FormatterBase` subclass. The whole module is
this one class plus one hook.

## What it renders

`viewElements()` returns the item count, not the items:

```php
return [
  [ '#markup' => $items->count() ],
];
```

`$items` is the `FieldItemListInterface`; `count()` is the number of populated deltas (an
integer). The value is wrapped in delta-0 so Drupal's default field-title/label rendering is
preserved. An empty field renders `0`. There are **no settings** — `settingsForm()` is
inherited unimplemented, and `settingsSummary()` returns the fixed line
"Displays the number of items/count." So there is no config schema, no
`field.formatter.settings.count` key, nothing to configure per display.

## Made universal by a hook

The plugin's `@FieldFormatter` annotation declares an empty `field_types = {}`. On its own that
would make it selectable for no field type. `field_count_formatter.module` fixes this:

```php
function field_count_formatter_field_formatter_info_alter(array &$info) {
  if (isset($info['count'])) {
    $info['count']['field_types'] =
      array_keys(\Drupal::service('plugin.manager.field.field_type')->getDefinitions());
  }
}
```

So **Field count** is offered for *every* field type on *Manage display* (29 types on a stock
install). Most useful on multi-value fields, where the count is meaningful.

## Using it

- *Manage display* (`admin/structure/types/manage/{bundle}/display`, or any entity display):
  set a field's **Format** to **Field count**. No format-settings row to fill in.
- Works the same on a Views field's *Format* setting. Note: this is display only — the count is
  not a sortable/filterable value in Views.
