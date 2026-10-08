<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Extra Field — agent index

Attach configurable pseudo-fields (block / views / token / twig / entity_link / component) to any content entity's view or form display, positioned like real fields. Core-only base module; the **entity_extra_field_ui** submodule (requires `field_ui`) provides the admin UI. Permission: `administer entity extra field`. No Drush. Provides a config schema and the `ExtraFieldType` plugin type. `configure` is null (management is per-bundle via the UI submodule).

- **The six field-type plugins, their config keys, and how to implement your own** → [plugins/extra-field-types.md](plugins/extra-field-types.md)
- **The `entity_extra_field` config entity, how fields are built/rendered, permission, report** → [configure/extra-fields.md](configure/extra-fields.md)
- **Hooks: `hook_entity_extra_field_twig_context_alter`, `extra_field_type_info` alter** → [hooks/hooks.md](hooks/hooks.md)

Submodule:
- `entity_extra_field_ui` → [../../modules/entity_extra_field_ui/2.1.x/agent/start.md](../../modules/entity_extra_field_ui/2.1.x/agent/start.md)

Key facts:
- Config entity `entity_extra_field` (`@ConfigEntityType`, config prefix `extra_field`, id `<entity_type>.<bundle>.<name>`, `admin_permission = administer entity extra field`, translatable).
- Plugin type: manager `plugin.manager.extra_field_type`, dir `src/Plugin/ExtraFieldType`, annotation `@ExtraFieldType`, interface `ExtraFieldTypePluginInterface`, base `ExtraFieldTypePluginBase`. Alter hook `extra_field_type_info`.
- Shipped plugin ids: `block`, `views`, `token`, `twig`, `entity_link`, `component`.
- Runtime: `hook_entity_extra_field_info()` registers pseudo fields; `entity_extra_field_entity_view()` + `entity_extra_field_form_alter()` → `entity_extra_field_display()` renders matching config entities that pass their component + condition checks.
- Report route `entity_extra_field.reports` → `/admin/reports/extra-fields` (permission `administer entity extra field`).
- Trust note: the `twig` plugin renders admin-entered inline Twig (arbitrary PHP-equivalent), and the `token` plugin has an "unfiltered" raw-HTML option — both gated by `administer entity extra field`; see plugins doc.
