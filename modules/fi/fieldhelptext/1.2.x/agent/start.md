<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Help Text (fieldhelptext) — agent index

Bulk-editing UI for field **description (help) text** — and, on the by-field form, the
field **label** — across the bundles of any fieldable content entity (nodes, taxonomy
terms, users, comments, blocks, media, etc.). Values are written straight to the standard
`field.field.*` config entities; the module keeps no config, schema, or storage of its own
and does not alter any core form. No dependencies. Core `^10.3 || ^11`.

Configure route: `fieldhelptext` → `/admin/structure/fieldhelptext` (also the `configure`
link and a menu item under Structure). Defines one permission; no drush, no plugins, no
hooks, no config schema.

- **Edit help text by bundle or by field (UI, drush, PHP)** → [configure/edit-help-text.md](configure/edit-help-text.md)
- **Who may edit help text** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Routes (all gated by `_permission: 'use fieldhelptext'`):

  | Route | Path | Handler |
  |---|---|---|
  | `fieldhelptext` | `/admin/structure/fieldhelptext` | `Controller\FieldhelptextController::main` (link index) |
  | `fieldhelptext.bundle` | `/admin/structure/fieldhelptext/by-bundle/{entity_type}/{bundle}` | `Form\Bundle` |
  | `fieldhelptext.field` | `/admin/structure/fieldhelptext/by-field/{entity_type}/{field_name}` | `Form\Field` |

- Permission string: `use fieldhelptext` (title "Update field help text").
- Only **non-base (configurable) fields** are editable; base fields are excluded everywhere via `array_diff_key($fields, getBaseFieldDefinitions())`.
- Saves via `FieldConfigInterface::set('description', ...)` / `setLabel()` → `save()`; only instances whose value actually changed are written.
- Route params resolved by three converters in `src/ParamConverter/` (service ids `fieldhelptext.paramconverter.{entity_type,bundle,field_name}`); an unknown value converts to NULL → 404 before any form runs.
- Form IDs: `fieldhelptext_bundle`, `fieldhelptext_field`.
- Edits are field config, so they show up in `drush config:export` and must be deployed like any other config change.
- `.info.yml` version: `8.x-1.2` (dir `1.2.x`).
