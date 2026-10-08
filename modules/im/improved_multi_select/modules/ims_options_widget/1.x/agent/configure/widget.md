<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Use the "IMS select list" widget

`ImsOptionsWidget` (id **`ims_options_select`**, label "IMS select list") extends core
`OptionsSelectWidget`. No configure route, no settings of its own — pick it per field on
*Manage form display*.

## Applies to

Field types: **`entity_reference`, `list_integer`, `list_float`, `list_string`**.
Declared `multiple_values = TRUE` (built for multi-value fields).

## What it changes

On `formElement()` it calls the parent, then reorders `#options` so the field's currently
**selected** options come first (in stored order), sets `#type = select`, `#multiple = TRUE`,
and `#default_value` to the selected options. `supportsGroups()` returns `FALSE`, so **optgroups
are not supported** — grouped allowed-values are flattened.

## Selecting it (UI)

1. *Manage form display* for the bundle (e.g. `/admin/structure/types/manage/article/form-display`).
2. On the list/entity-reference field's row, choose **IMS select list** as the widget.
3. **Update**, then **Save**.

For the ordering to be visible to editors, also enable the parent **Improved Multi Select**'s
"Allow re-ordering of selected items" (`orderable`) so the two-panel picker exposes move up/down.

## Where it is stored

Config entity `core.entity_form_display.<entity_type>.<bundle>.<form_mode>`:

```yaml
content:
  field_tags:
    type: ims_options_select
    settings: {}
```

## Scripting

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$fd->setComponent('field_tags', ['type' => 'ims_options_select'])->save();
```

```bash
drush cget core.entity_form_display.node.article.default content.field_tags
# type: ims_options_select
```

Revert by setting the component `type` back to `options_select`.
