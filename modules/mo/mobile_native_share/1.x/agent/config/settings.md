<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, config object & the display component

## Install & enable

```bash
composer require drupal/mobile_native_share
drush en mobile_native_share -y
```

No required dependencies. Enabling `token` is optional but adds the token browser and lets
per-bundle Title/Description use tokens.

## Settings form

- Class `Drupal\mobile_native_share\Form\MobileNativeShareSettings` (extends `ConfigFormBase`),
  form id `mobile_native_share_settings`.
- Route `mobile_native_share.admin_settings` → path `/admin/config/search/mobile-native-share`,
  requirement `_permission: 'administer mobile native share'`. Menu link under
  *Configuration → Search and metadata* (`system.admin_config_search`).
- Editable config object: **`mobile_native_share.settings`**.

### Global button fields

| Field | Config key | Values | Default |
|---|---|---|---|
| Display mode | `display_mode` | `icon_and_text`, `icon_only`, `text_only` | `icon_and_text` |
| Button style | `style` | `default`, `fixed-icon` | `default` |
| Custom icon URL | `icon` | image URL/path or empty (uses `images/share.svg`) | `''` |

### Per entity-type / bundle fields

Under a `#tree` `entities` element, one vertical tab per available content-entity type, one
`details` per bundle, each with:

- `entities.<entity_type>.<bundle>.enable` (checkbox / boolean)
- `entities.<entity_type>.<bundle>.title` (textfield — supports tokens)
- `entities.<entity_type>.<bundle>.description` (textfield — supports tokens)

The list of configurable entity types comes from `getAvailableEntities()`:
constant `DEFAULT_ENTITY_TYPES = ['comment', 'node', 'taxonomy_term']`, run through
`hook_mobile_native_share_entity_types_alter()`, then filtered to `ContentEntityType` definitions
that actually exist. A token-tree link is shown only when the `token` module is enabled.

`submitForm()` saves the four keys and calls `entityFieldManager->clearCachedFieldDefinitions()`
so the Manage-display component appears/disappears immediately.

### Icon URL validation (`validateForm()`)

For a non-empty `icon`: rejected if `UrlHelper::stripDangerousProtocols()` changes it (dangerous
protocol), if `!UrlHelper::isValid($icon, TRUE)`, or if the path extension is not one of
`png, jpg, jpeg, gif, svg`.

## Config object & schema

Install defaults (`config/install/mobile_native_share.settings.yml`):

```yaml
display_mode: icon_and_text
style: default
icon: ''
entities: { }
```

Schema (`config/schema/mobile_native_share.schema.yml`, type `config_object`): `display_mode`,
`style`, `icon` are strings; `entities` is a nested `sequence` (entity type → bundle) of a mapping
with `enable` (boolean), `title` (string), `description` (string).

`mobile_native_share_update_10001()` sets `display_mode` to `icon_only` if it was empty (legacy
sites); the current install default is `icon_and_text`.

## The display component

`hook_entity_extra_field_info()` adds a **display** extra field `mobile_native_share`
(label *"Native share button"*, weight 5, `visible => FALSE`) to every bundle whose
`entities.<type>.<bundle>.enable` is TRUE. Place/position it on
*Structure → … → Manage display*. `hook_entity_view()` calls
`renderer->render($entity)` into `$build['mobile_native_share']` only when that component is
present on the display.

## Permission

`administer mobile native share` (`*.permissions.yml`, `restrict access: TRUE`) — gates the
settings form. No other permissions.
