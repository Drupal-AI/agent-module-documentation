<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Apply a field value as a class / attribute

There is **no admin settings page**. You configure the module purely by choosing the
**Entity Class** formatter for a field on a *Manage display* page (or in Layout Builder).

## Settings

| Key | Type | Meaning |
|---|---|---|
| `prefix` | string | Concatenated **before** each extracted value. Default `''`. |
| `suffix` | string | Concatenated **after** each extracted value. Default `''`. |
| `attr` | string | HTML attribute to write into. Empty ⇒ `class`. Field is **required** in the UI for `decimal`, `float`, `integer`. |
| `field` | string | Entity-reference only: name of a field **on the referenced entity** to read instead of its label. Hidden in the UI for other field types. |

Supported field types (the formatter's `field_types`): `boolean`, `decimal`,
`entity_reference`, `float`, `integer`, `list_string`, `string`.

## Where it is stored

Config entity `core.entity_view_display.<entity_type>.<bundle>.<view_mode>`:

```yaml
content:
  field_theme_color:
    type: entity_class_formatter
    label: hidden
    weight: 10
    region: content
    settings:
      prefix: 'bg-'
      suffix: ''
      attr: ''          # empty => class
      field: ''
    third_party_settings: {}
```

Config schema key: `field.formatter.settings.entity_class_formatter` (four string keys).

## Via the UI

1. Go to the bundle's *Manage display*, e.g. `/admin/structure/types/manage/article/display`.
2. In the field's **Format** select, choose **Entity Class**.
3. Click the cog and fill in *Prefix* / *Suffix* / *Attribute name* / *Referenced entity field name*.
4. **Update**, then **Save**. The field disappears from the rendered output; its value shows up
   on the entity's wrapper element instead.

## Via drush php:eval (scriptable)

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_theme_color', [
  'type' => 'entity_class_formatter',
  'label' => 'hidden',
  'weight' => 10,
  'region' => 'content',
  'settings' => ['prefix' => 'bg-', 'suffix' => '', 'attr' => '', 'field' => ''],
  'third_party_settings' => [],
])->save();
```

To emit a data attribute instead of a class, set `attr`:

```php
'settings' => ['prefix' => '', 'suffix' => '', 'attr' => 'data-variant', 'field' => ''],
```

To read a sub-field off a referenced entity (e.g. a machine-name field on the term):

```php
'settings' => ['prefix' => 'cat-', 'suffix' => '', 'attr' => '', 'field' => 'field_machine_name'],
```

## Read it back

```bash
drush cget core.entity_view_display.node.article.default content.field_theme_color
# type: entity_class_formatter  +  settings.prefix / suffix / attr / field
```

Which displays use it at all:

```bash
drush php:eval 'foreach (\Drupal::entityTypeManager()->getStorage("entity_view_display")->loadMultiple() as $d) {
  foreach ($d->getComponents() as $n => $c) {
    if (($c["type"] ?? "") === "entity_class_formatter") { print $d->id() . " :: $n\n"; }
  }
}'
```

## Layout Builder

In Layout Builder the same formatter is chosen on the **field block**'s configuration form; the
setting then lives inside the section component configuration
(`configuration.formatter.type: entity_class_formatter`) of the display's `layout_builder__layout`
(default sections) or the entity's own `layout_builder__layout` field (overridden layouts).
The module reads both.
