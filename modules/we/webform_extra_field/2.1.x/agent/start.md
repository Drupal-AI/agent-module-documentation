<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Extra Field (webform_extra_field) — agent index

Adds a **"Webform" pseudo-field** to an entity's display. An admin enables it per bundle, then on
**Manage Display** positions it like a real field and assigns **one specific webform** to render.
That same form then shows on every entity of the bundle in that view mode. Version **2.1.0**,
core `^9 || ^10 || ^11`.

## What it actually is
- A single **Extra Field Plus** display plugin: `webform_extra_field_display`
  (`src/Plugin/ExtraField/Display/WebformExtraFieldDisplay.php`), label "Webform", `visible = false`.
- Its `view()` loads the configured `Webform` entity and renders it through the standard webform
  **view builder** — so the form runs through Webform's own access, open/closed and confirmation
  pipeline, exactly as on its canonical page.
- The webform to show is a **fixed choice in display config** (`webform_id` select), the same for
  every entity of the bundle. It is **not** a per-node reference — for per-node forms use Webform's
  own entity-reference field instead.
- The module does **not** pass the host entity into the webform; submissions are not auto-tagged
  with the source node. Add a hidden element / source-entity handler inside the webform if you need
  that context.

## Dependencies (both required)
- **webform** (`^5 || ^6`) — supplies the forms and the `webform` view builder.
- **extra_field_plus** (`^3`, part of the Extra Field project) — supplies the pseudo-field plugin
  type and per-display settings that `WebformExtraFieldDisplay` extends.

## Setup (two steps)
1. **Enable per bundle.** As a user with *Administer webform extra field*, go to
   **Configuration → System → Webform extra field** (`/admin/config/system/webform-extra-field`,
   route `webform_extra_field.settings`) and tick the entity-type bundles that may use it. Only
   **fieldable content entity types with a Field UI base route** are offered. The selection is
   stored in `webform_extra_field.settings:webform_extra_field_admin` as
   `entity_type_id → bundle_id → bool` and injected via
   `hook_extra_field_display_info_alter()`.
2. **Place and assign.** On each enabled bundle's **Manage Display** (per view mode) the **Webform**
   pseudo-field appears in the disabled region. Drag it into a region and, in its per-display
   settings, use the **Webform** select to pick the form. `_none` means nothing renders.

See `agent/config/settings.md` for the exact config structure and rendering behavior.

## Permission
- `administer webform extra field` — gates only the settings form at
  `/admin/config/system/webform-extra-field`. Placing/assigning the form on Manage Display is gated
  by the normal *Administer <entity> display* Field UI permissions.

## Files
- `webform_extra_field.module` — `hook_help()`, `hook_extra_field_display_info_alter()`.
- `src/Form/WebformExtraFieldSettingsForm.php` — the per-bundle enable settings form.
- `src/Plugin/ExtraField/Display/WebformExtraFieldDisplay.php` — the display plugin.
- `config/schema/webform_extra_field.schema.yml` — schema for `webform_extra_field.settings`.
- `webform_extra_field.routing.yml`, `.permissions.yml`, `.links.menu.yml`, `.info.yml`.

## When to use vs. alternatives
- **This (extra field):** one fixed form is part of what the content type *is*; placement controlled
  by **display config**, reorderable, per view mode, no conditional logic.
- **Webform reference field:** the form differs **per node** / is editorial — use that instead.
- **Block + URL condition:** the form belongs to a **section**, not to content.
- **Token in body:** puts form markup inside editable content.

## Caching note
The rendered form carries a build id and form token, so pages of that bundle cannot be served from
the anonymous page cache the way a form-free page can — a real consideration on high-traffic bundles.
