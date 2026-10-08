<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config-action plugins

The module defines config-action plugins (in `src/Plugin/ConfigAction`) that recipes apply
against a named config object. It does **not** define any new plugin *type* — these are
instances of core's config-action plugin type.

Apply any of these programmatically:

```php
\Drupal::service('plugin.manager.config_action')
  ->applyAction('<action_id>', '<config_name>', $value);
```

## `setDefaultImage` — `@api`

Sets the default image of an image field to a **file UUID that need not exist yet** (e.g. a
file shipped as recipe default content). It marks the field as syncing so core won't null the
default image when the file is missing at apply time. Target entity types:
`base_field_override`, `field_config`, `field_storage_config` (the config must be an image
field).

```yaml
# In a recipe's config actions:
field.field.node.article.field_image:
  setDefaultImage: 059dcb1d-3f0d-4390-89d7-6ebe2bc0d833
```

Effect: writes `settings.default_image.uuid` on the field config to the given UUID.

## `themeDevelopmentMode` — `@api`

Toggles theme development settings by programmatically submitting core's
`DevelopmentSettingsForm`. Called on the `system.theme` config object with a boolean.

```yaml
system.theme:
  themeDevelopmentMode: true
```

Effect (when `true`): sets Twig debug + Twig cache-disable + disable-rendered-output-cache-bins.
These persist in the `development_settings` key/value collection — read with
`\Drupal::keyValue('development_settings')->get('twig_debug')` (also `twig_cache_disable`,
`disable_rendered_output_cache_bins`). `false` clears them.

## Internal actions (not `@api`)

- `grantPermissionsIfExist` (entity type `user_role`) — like core `grantPermissions`, but
  silently drops permissions that don't currently exist, so unrelated recipes can integrate
  loosely. Plural form only.
- `overrideMenuLinks` — thin wrapper over `StaticMenuLinkOverridesInterface::saveOverride()`;
  applied to `core.menu.static_menu_link_overrides` to e.g. disable a static/Navigation menu
  link:
  ```yaml
  core.menu.static_menu_link_overrides:
    overrideMenuLinks:
      navigation.content.node_type.blog:
        enabled: false
  ```
