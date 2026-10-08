<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions — Editoria11y si (SiteImprove)

Defined in `editoria11y_si.permissions.yml`:

| Permission | Restrict access | Gates |
|---|---|---|
| `administer editoria11y_si` | yes | `admin_permission` of the `editoria11y_si` content entity (entity CRUD via generic entity handlers). |

Permissions used but **not defined here** (they come from other modules and gate this module's UI):
- `administer site configuration` (core) — required by the settings route `editoria11y_si.settings`.
- `view editoria11y checker` (from the `editoria11y` module) — required to see the in-page tips (`hook_preprocess_node` / `hook_page_attachments` bail without it) and all three `/admin/reports/editoria11y/si-*` report Views.

The settings form is **not** gated by `administer editoria11y_si`; it uses `administer site configuration`.
