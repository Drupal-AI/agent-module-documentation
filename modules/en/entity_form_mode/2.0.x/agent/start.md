<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Form Mode (entity_form_mode) — agent index

Makes Drupal's per-bundle **form modes** actually reachable. Drupal lets you build several form
displays per entity type (a "Quick edit", an "Editor" form, …) but out of the box almost nothing
*routes* to them, so the feature exists and goes unused and every role gets the same enormous form.
This module closes the gap with a single `hook_entity_form_display_alter()` implementation
(`entity_form_mode.module:37-53`): on any entity form it compares the current route name to the
bundle's configured form modes and, when a form-mode **machine name matches the last segment of the
route** (route `entity.node.edit_form` → form mode `edit_form`; for nodes also `node.{key}`), swaps
the form display to that mode. **It defines no routes, services, permissions, or access checks of its
own** — a runtime route dump shows zero module-owned routes; it only changes *which* form display
renders on core's existing, already-access-controlled entity form routes. See
[api/routes.md](api/routes.md) for the exact matching, caveats, and access model.

**The point that matters most, and is easiest to get wrong: a form mode is NOT access control.**
A field omitted from a form display is simply not saved *from that form*. It remains readable and
writable through **JSON:API, REST, a migration, a different form mode, a webform, or `drush`**. If the
requirement is that a role **must not change** a value, that is **field-level access**
(`hook_entity_field_access`, or the `field_permissions` module) — a form mode is the wrong tool. Used
for its actual purpose — **reducing what a person has to look at** — it is a genuine editorial
improvement.

- Depends on: nothing (no `dependencies` in info.yml).
- Core: `^10 || ^11`. Package: `Other`. Version **2.0.3**.
- **No** settings page / `configure` route, **no** permissions, **no** services, **no** drush, **no**
  plugin types, **no** config schema (no `config/` directory). All setup happens in core's Display
  Modes + Manage form display UIs.
- Hooks implemented: `hook_entity_form_display_alter()`, `hook_help()`.

## What you'd do → where

- **See exactly which core routes activate which form modes, the `node.add` / User-entity caveats,
  and why swapping a form mode never bypasses route or field access** →
  [api/routes.md](api/routes.md)
- **Make a given form render a specific form mode** → build/enable the form mode in core's Display
  Modes UI (`/admin/structure/display-modes/form`) and name its machine key to match the route's last
  segment; details in [api/routes.md](api/routes.md).

## Key facts (real machine names)

- Routes defined: **none** (no `*.routing.yml`; verified 0 module-owned routes at runtime). The only
  associated route is the core-generated `help.page.entity_form_mode`.
- Hook driving everything: `entity_form_mode_entity_form_display_alter()` — matches route
  `entity.{entity_type}.{key}` (or `node.{key}` for nodes) to a form-mode machine `{key}`.
- Core service used (not provided): `entity_display.repository` —
  `getFormModeOptionsByBundle()`, `getFormDisplay()`.
- Config it reads: core `core.entity_form_mode.*` / `core.entity_form_display.*` entities, created
  via the Display Modes UI at `/admin/structure/display-modes/form`.
- Works for: nodes, taxonomy terms, comments, and custom content entities whose forms follow the
  `entity.{entity_type_id}.{form_id}` route convention. Does **not** work for User entities; use the
  `default` mode for node **add** (route `node.add`).
