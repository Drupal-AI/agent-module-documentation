<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Save & Edit

Config object `save_edit.settings` (schema `config/schema/save_edit.schema.yml`, defaults in
`config/install/save_edit.settings.yml`). Settings form at `/admin/config/save_edit/settings`
(route `save_edit.save_edit_settings_form`, class `\Drupal\save_edit\Form\SettingsForm`, permission
*administer save and edit*). The form is config-translatable (`save_edit.config_translation.yml`).

| Key | Type | Default | Effect |
|---|---|---|---|
| `button_value` | label | `"Save & Edit"` | Text on the Save & Edit button. |
| `save_button_text` | label | `""` | Override the default **Save** button text (empty = "Save"). |
| `button_weight` | string | `"-1"` | Weight/position of the button among form actions (select -10..10). |
| `gin_primary` | boolean | `"0"` | If Gin admin theme: show as a primary action, not in "More actions". |
| `hide_default_save` | boolean | `"0"` | Hide the core Save button. |
| `hide_default_preview` | boolean | (schema) | Hide the Preview button. |
| `hide_default_delete` | boolean | (schema) | Hide the Delete button. |
| `unpublish` | boolean | `"0"` | Auto-unpublish the node every time it is saved with Save & Edit. |
| `unpublish_new_only` | boolean | `"0"` | Auto-unpublish only when the node is new (first save). |
| `enable_node_types_automatically` | boolean | `"0"` | Auto-enable Save & Edit on newly created content types. |
| `node_types` | sequence | `{}` | Map of enabled content types (see below). |

## Enabling a content type — `node_types`

`node_types` is an associative map `bundle => value`. A content type is **enabled** when its
value equals the bundle id; a value of `"0"` (or absent) means disabled. The form-alter check is
`in_array($bundle, array_values($node_types), TRUE)`.

```php
// Enable Save & Edit on the "article" content type.
$config = \Drupal::configFactory()->getEditable('save_edit.settings');
$node_types = $config->get('node_types') ?: [];
$node_types['article'] = 'article';   // 'article' => 'article' = on;  'article' => '0' = off
$config->set('node_types', $node_types)->save();
```

```bash
drush cget save_edit.settings node_types
drush cset save_edit.settings node_types.article article -y   # enable
drush cset save_edit.settings node_types.article 0 -y          # disable
```

`SaveEditHooks::entityBundleCreate()`/`entityBundleDelete()` keep this map current as content types
come and go (new types are set to `<bundle>` only if `enable_node_types_automatically` is on, else
`"0"`).

## Permissions (`save_edit.permissions.yml`)

- `use save and edit` — a user must have this for the button to appear on their node forms.
- `administer save and edit` — access to the settings form (the route requires this permission on
  its own; general "access administration pages" is not sufficient).

## Gin note

`save_edit_install()` sets `gin_primary` to `1` automatically if the Gin admin theme is the active
(or default) admin theme at install time; the `gin_primary` checkbox only appears on the settings
form when Gin is the admin theme.
