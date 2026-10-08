<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Noahs Popups (noahs_popups) — agent index

**Builds popups/modals with the Noahs Page Builder and renders them to visitors.**

- **Version:** 1.1.x
- **Core:** ^10 || ^11
- **Dependency:** noahs_page_builder
- **Admin routes** (all `administer noahs_page_builder`): create-popup, popup-list, build, iframe preview, toggle, delete.
- **Write route:** `noahs_popups.save_theme` POST `/noahs-popup-admin/save-popup` — `_access:'TRUE'` **and** `_permission:'administer noahs_page_builder'` (AND'd → admin-gated; `_access:TRUE` is redundant, not a bypass).
- **Public route:** `noahs_popups.render` `/noahs-popup/render/{noahs_id}` — `_permission: 'access content'`, returns saved popup HTML.

**Security:** Admin builder/save/delete routes are permission-gated (`administer noahs_page_builder`); the `_access:'TRUE'` on the save route is neutralized by the AND'd permission. The public render route only serves popup markup intended for display. Storage uses the `noahs_page_builder_popups` table via the DB API. See [configure/popups.md](configure/popups.md)
