<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TS DX (ts_dx) — agent index

**Developer-experience toolkit: `ts_`-prefixed Twig functions, menu/theme/context utility services, Drush commands, and toolbar edit-redirect routes.**

- **Version:** 1.0.x
- **Core:** ^8 || ^9 || ^10 || ^11
- **Package:** Development (originates from a Drupal sandbox; README partly French).
- **Services:** `ts_dx.twig_extension`, `ts_dx.menu_tools`, `ts_dx.theme_tools`, `ts_dx.context_tools`, `ts_dx.misc_tools`. Drush: `DxCommands`.
- **Routes:** `ts_dx.node_edit` `/admin/node/edit`, `ts_dx.term_edit` `/admin/term/edit`, `ts_dx.entity_edit` `/admin/{entity_type}/edit` — all `_permission: access content overview`; each resolves entities from query params and redirects to the entity's `edit_form` (or system.404).

**Security:** the redirect routes are gated by `access content overview` and only issue a redirect to the target entity's own `edit_form` route, which applies its own access check — they confer no access the user lacks (worst case: existence disclosure via redirect-vs-404). The array-valued query path uses `accessCheck(TRUE)`. No mutating or anonymous endpoints. No material security findings.

See [api/services.md](api/services.md).
