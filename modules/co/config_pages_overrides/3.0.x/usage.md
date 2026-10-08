<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Pages Overrides lets a Config Pages field value override any simple configuration value (for example, using a text field on a config page to override `system.site:name`), removing the need to hand-write a `ConfigFactoryOverrideInterface` service per case.

---

It registers one tagged `config.factory.override` service (`ConfigOverrides`). On every config load it reads the third-party settings stored on each `config_pages.type.*` entity (mapping a config page field/column/delta to a target `config_name` + dotted `config_item`), pulls the current value from the matching Config Page via `config_pages.loader`, optionally applies a prefix/suffix, casts it to the target's schema type (boolean/integer), and injects it with `NestedArray::setValue`. Override mappings are managed from two entity-form routes on the Config Pages *type*: `/admin/structure/config_pages/types/manage/{config_pages_type}/overrides` and `.../overrides-add`, both gated by `_entity_access: config_pages_type.update`.

Because the override runs inside the config factory, changes to a config page instantly re-shape the overridden configuration site-wide. There are no anonymous or mutating public endpoints; the only routes are admin entity-form routes protected by the Config Pages type update permission. There is no raw SQL, no external I/O and no user-supplied deserialization — the module only reads config-page values and writes them into config overrides.

---
- Install and enable the `config_pages` module first.
- Create a Config Pages type with the fields you want to expose.
- Open the *Config Overrides* tab on the Config Pages type.
- Map a config-page field to a target config name and item.
- Override `system.site:name` from a text field, for example.
- Override a boolean setting (cast to bool automatically).
- Override an integer setting (cast to int automatically).
- Add a prefix/suffix around a string override value.
- Override a single delta of a multi-value field.
- Override an entire multi-value field into a config array.
- Pick the field column used as the override source value.
- Let editors change site settings by editing a Config Page.
- Avoid writing a custom ConfigFactoryOverride service per setting.
- Remove an override mapping from the type's overrides form.
- Combine several overrides on one Config Pages type.
- Verify effective config with `drush config:get` after editing a page.
- Restrict access via the Config Pages type update permission.
