<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enabling & configuring the tree widget

The module has **no settings page**. You configure it per field on that field's form display.

## Enable it on a reference field

1. The field must be an **entity reference** field (`field_types = { entity_reference }`).
2. Go to the bundle's *Manage form display* (e.g.
   `/admin/structure/types/manage/article/form-display`).
3. For the reference field, choose the **"Entity reference tree widget"** in the *Widget*
   column, adjust settings via the cog, **Update**, and **Save**.

Programmatically, set the form-display component's widget type to `entity_reference_tree`:

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')
  ->load('node.article.default');
$fd->setComponent('field_categories', [
  'type' => 'entity_reference_tree',
  'region' => 'content',
  'settings' => [
    'theme' => 'default',
    'dialog_title' => 'Select categories',
    'label' => 'Choose from tree',
  ],
])->save();
```

The stored config lives in the `entity_form_display` config entity under
`content.<field>.type = entity_reference_tree` (+ `settings`).

## Widget settings

Schema: `field.widget.settings.entity_reference_tree`.

| Setting | Type | Notes |
|---|---|---|
| `theme` | string | jsTree theme, e.g. `default` or `default-dark`. |
| `dots` | integer | `1` shows connector dot lines in the tree, else `0`. |
| `worker` | boolean | Use the jsTree web worker (large trees). |
| `disable_animation` | boolean | Turn off open/close animation. |
| `force_text` | boolean | jsTree `force_text` option. |
| `label` | label | The picker **button** label (defaults to "<Type> tree"). |
| `dialog_title` | string | Modal dialog title (defaults to the button label). |
| `placeholder` | label | Autocomplete placeholder text. |
| `match_operator` | string | Autocomplete match operator (CONTAINS / STARTS_WITH). |
| `match_limit` | integer | Max autocomplete suggestions. |
| `size` | integer | Size of the autocomplete text field. |
| `autocomplete_maxlength` | integer | Max length of the autocomplete input (default 1024). |

The widget extends core's autocomplete widget, so the text field + tags behaviour is
inherited; the tree button and modal are the additions. Selections are limited to the
field's configured target bundles.
