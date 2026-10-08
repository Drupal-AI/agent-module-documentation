<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Popup Entity (popup_entity) — agent index

**Provides a fielded 'Popup' content entity; active instances render as dismissible, cookie-limited modals via `hook_page_bottom()`.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10
- **Dependencies:** options, user, entity_content_visibility
- **Entity:** `popup_entity_popup` with access handler `PopupAccessControlHandler`.
- **Routes:** canonical view (`_entity_access: view`), add (`_entity_create_access`), edit/delete (`_entity_access`), settings + collection (`_permission: 'administer popup entity'`).
- **Permissions:** `add/edit/delete/view popup entity`, `administer popup entity`.
- **JS/library:** `popup_entity/popup` (show/hide, breakpoint match, per-popup cookie view count).
- **Fields drive:** width/height (%), position_x/y (class), open_delay, times_to_show, cookies_expiration, breakpoints.

**Security:** All CRUD routes are entity-access/permission-gated via `PopupAccessControlHandler` (admin permission or granular perms). Active popups render on every page bottom by design, filtered by `entity_content_visibility`; popup content is output through standard sanitized field formatters. Presentation values (width/height/position) come from admin-entered entity fields. No anonymous mutation, no raw SQL, no untrusted sinks.

See [configure/popups.md](configure/popups.md)
