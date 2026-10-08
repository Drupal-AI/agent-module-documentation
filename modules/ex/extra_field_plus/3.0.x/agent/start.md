<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Field Plus — agent index

Adds **editable display settings** to [Extra Field](https://www.drupal.org/project/extra_field)
pseudo-fields: a per-instance settings form (cog on *Manage display*) whose values are saved
into the `entity_view_display` component. Depends on `field` + `extra_field`. No configure
route, no permission of its own, no Drush. Submodule: `extra_field_plus_example`.

- **Write an extra field plugin with settings (base classes + required methods)** →
  [plugins/write-plugin.md](plugins/write-plugin.md)
- **Read settings, the plugin manager service, Layout Builder support** →
  [api/settings.md](api/settings.md)
- **Where settings are stored & the plugins-list report** →
  [configure/storage.md](configure/storage.md)

Key facts:
- Base classes: `ExtraFieldPlusDisplayBase` (raw) and `ExtraFieldPlusDisplayFormattedBase`
  (field-template wrapped). Interface `ExtraFieldPlusDisplayInterface`.
- Implement static `extraFieldSettingsForm()` and `defaultExtraFieldSettings()`; optional
  static `settingsSummary()`. (3.x renamed these — see the module's UPGRADE.md.)
- Plugins go in `your_module/src/Plugin/ExtraField/Display/` with `@ExtraFieldDisplay`.
- Field machine name is `extra_field_<id>`; settings stored at
  `entity_view_display` → `content.extra_field_<id>.settings`.
- Manager service: `plugin.manager.extra_field_plus_display`. Report:
  `/admin/reports/extra_fields`.
