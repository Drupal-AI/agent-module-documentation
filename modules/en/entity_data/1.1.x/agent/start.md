<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity data (entity_data) — agent index

Developer API to store **arbitrary custom data per content entity** as key/value pairs, similar to core's
`user.data` but for any content entity. One service, one database table. Package `Entity`. No hard module
dependencies (`info.yml` declares none; the Views handler is only used when core Views is enabled).
Core `^10 || ^11`, PHP `8.1`, GPL-2.0-or-later. Version-dir 1.1.x (release 1.1.1).

- **The `entity.data` service — `get()`/`set()`/`delete()`, storage table, key semantics** →
  [api/entity-data-service.md](api/entity-data-service.md)
- **Settings form, config object, allowed-classes / unserialize control** →
  [config/settings.md](config/settings.md)

## What it provides (from source)

- **Service `entity.data`** → `Drupal\entity_data\EntityData` (`src/EntityData.php`), implementing
  `EntityDataInterface`. Constructed with `@database` + `@config.factory`; tagged `backend_overridable`.
- **Database table `entity_data`** (`entity_data.install`, `hook_schema()`): columns `entity_id`, `module`,
  `entity_type`, `name`, `value` (big blob), `serialized` (tinyint). Primary key
  `(entity_id, module, name, entity_type)`; indexes on `module`, `name`, `entity_type`.
- **Config object `entity_data.settings`** with schema (`config/schema/entity_data.schema.yml`) and install
  defaults (`config/install/entity_data.settings.yml`): `are_classes_allowed` (bool), `allowed_classes`
  (list of strings). Update hook `entity_data_update_9301` seeds these.
- **Settings route `entity_data.settings`** at `/admin/config/development/entity-data`
  (`entity_data.routing.yml`), form `Drupal\entity_data\Form\SettingsForm`, permission
  `administer site configuration`; menu link under *Configuration → Development* (`entity_data.links.menu.yml`).
- **Views field handler** `@ViewsField("entity_data")` → `Drupal\entity_data\Plugin\views\field\EntityData`,
  wired by `hook_views_data()` in `entity_data.views.inc` (exposes `value`, `module`, `name` columns joined
  to each content entity's base/data table).
- **`hook_entity_delete()`** (`entity_data.module`) purges all rows for a deleted entity.
- **`hook_help()`** for `help.page.entity_data`. No permissions file, no Drush, no plugin types, no submodules.
