<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Managing Stylify stylesheets

Admin UI: `/admin/config/system/stylify/stylesheets` (`manage stylify settings`).

- **List** all saved sheets; each has a `route_key` (`[a-zA-Z0-9_-]{1,184}`).
- **Edit** `.../{route_key}/edit`, **Delete** `.../{route_key}/delete`.
- **Export** one sheet `.../{route_key}/export`, **Export all** `.../stylesheets/export`, **Import** `.../stylesheets/import`.

Scopes (resolved by `StylesheetResolver`): global (front-end), admin global, per-route, per-entity, per-content-type. `router.admin_context` decides whether admin CSS applies.

Editor endpoints (used by the on-page editor, POST + `X-CSRF-Token`): `/stylify/sheet/save`, `/stylify/sheet/lock`, `/stylify/sheet/unlock`, and GET `/stylify/sheet/check-lock`. Locks are persistent (`@lock.persistent` + keyvalue) so a second editor is blocked until the first saves or the lock is released.

Grant the narrowest permission that fits: `edit entity stylify css` for content editors, `edit global stylify css` for site-wide front-end CSS, `edit admin stylify css` for admin CSS. Reserve `access stylify css editor` (break-glass) + `manage stylify settings` for administrators.
