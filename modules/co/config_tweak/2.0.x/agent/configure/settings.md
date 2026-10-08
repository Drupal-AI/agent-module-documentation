<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# config_tweak — configuration

## Settings form
`/admin/config/development/config_tweak` (`ConfigTweakSettingsForm`, permission `administer site configuration`, config `config_tweak.settings`). Toggle which dependency-stripping tweaks are active.

## Tweak 1 — entity-reference target dependencies
`EntityReferenceItemConfigTweak` / `FieldTypePluginManagerConfigTweak` remove the dependency an entity-reference field records on its `target_bundles`. Opt a field in by adding to `field.field.*.yml`:
```yaml
settings:
  handler_settings:
    dependencies_optional: yes
    target_bundles:
      ...
```

## Tweak 2 — Entity Browser view widget dependency
`EntityBrowserWidgetViewConfigTweak` removes the dependency an Entity Browser records on its view widget. Requires the patch from drupal.org issue 3035036. Opt in per widget in `entity_browser.browser.*.yml`:
```yaml
widgets:
  <widget-uuid>:
    settings:
      dependencies_optional: yes
      view: <view_id>
```
