<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Assign the Multiple Selects widget

The module has **no configure route** (`configure: null`) and no global settings page. You
assign its widget to a specific field on the entity's **Manage form display** page (or
directly in the `entity_form_display` config), the same as any other field widget.

## Applicability

The widget plugin id is `multiple_options_select`. Per its `@FieldWidget` annotation it is
only offered for fields of type:

- `entity_reference`
- `list_integer`
- `list_float`
- `list_string`

It works at any cardinality, but its distinguishing behavior (one select per delta with
"Add another item") only shows up when cardinality is greater than 1 (fixed, e.g. 3, or
unlimited, `-1`). On a single-value field it just renders one select.

## Where the setting is stored

Config entity: `core.entity_form_display.<entity_type>.<bundle>.<form_mode>`
Path within it:

```yaml
content:
  <field_name>:
    type: multiple_options_select
    settings:
      element_type: select        # or 'select2' if the select2 module is installed
```

Schema: `field.widget.settings.multiple_options_select` (extends
`field.widget.settings.options_select`, adds the `element_type` string). Because the module
ships this schema, the setting is config-schema-checked like any other field widget setting.

## Via the UI

1. Go to the bundle's *Manage form display* (e.g. `/admin/structure/types/manage/<bundle>/form-display`).
2. Change the field's widget dropdown to **Multiple select list(s)**.
3. Click the gear/cog on that row to open widget settings.
4. Choose **Element type**: `Select` is always available; `Select2` only appears if the
   `select2` contrib module is installed and enabled (checked via
   `$module_handler->moduleExists('select2')` in `settingsForm()`).
5. **Update**, then **Save**.

## Via drush php:eval (scriptable)

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$fd->setComponent('field_related_products', [
  'type' => 'multiple_options_select',
  'settings' => ['element_type' => 'select'],
])->save();
```

## Read it back

```bash
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  print_r($fd->getComponent("field_related_products"));
'
```

Look for `type` === `multiple_options_select` and `settings.element_type`.

## Upgrading older sites

`multiple_selects_post_update_add_element_type_to_widgets()` walks every `entity_form_display`
and, for any component already using `multiple_options_select` without an `element_type`
setting, backfills `element_type: select`. Run it with `drush updb` after a module update; it
is idempotent (only touches components missing the setting).
