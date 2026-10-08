<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Defaults — agent index

Applies a field's configured **default value** to **existing** content in bulk (Drupal
normally only applies defaults to new entities). Works one field at a time; runs as a batch
over every entity of the field's target entity type + bundle. Depends on `field_ui`.

- **Settings, the per-field UI, config key, permission, configure route** →
  [configure/settings.md](configure/settings.md)
- **The `field_defaults:bulk-update` Drush command (alias `fdbu`)** →
  [drush/commands.md](drush/commands.md)
- **The `field_defaults.processor` service + the PreserveChangedItem mechanism** →
  [api/processor.md](api/processor.md)

Key facts:
- Config object: `field_defaults.settings`, one key `retain_changed_date` (int 0/1, default 1).
- Configure route: `field_defaults.field_defaults_settings_form` →
  `/admin/config/system/field_defaults/settings` (permission `access configuration pages`).
- Permission `administer field defaults` gates the extra "Update existing content" section on a
  field's *Manage fields → Edit* form.
- Value written is the field's own `default_value[0]`; `no_overwrite` (default TRUE in the
  Drush command) fills only empty fields, `no_overwrite=0` overwrites existing values.
- No plugins, no config entities.
