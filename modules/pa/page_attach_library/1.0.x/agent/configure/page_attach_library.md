<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# page_attach_library — configuration

## Settings form (`/admin/config/page-attach-library/page-attach-library-settings`)
Permission: `administer site configuration`. `PageAttachLibrarySettingsForm` renders a draggable table (`page_library_table`) with Add-one-more / Remove AJAX buttons. Each row:
- `status` (checkbox) — rule active only when checked.
- `pages` (textarea, required) — one path per line; `*` wildcard; `<front>` for the front page (e.g. `/node/1`, `/node/*`).
- `page_library` (textarea, required) — one or more `module_name/library_name` ids, separated by newline or comma.
- `weight` — drag-and-drop ordering.

Saved to config object `page_attach_library.settings` under key `page_library_table`.

## Runtime attachment (`page_attach_library_page_attachments`)
For each enabled rule it matches the current path via `path.matcher.matchPath()` against both the system path and `path_alias.manager` alias; on a match it splits `page_library` on newlines/commas/spaces, de-duplicates, and appends each id to `$attachments['#attached']['library']`.

## Notes
- Only libraries declared by an installed module/theme have any effect; unknown ids are silently ignored by the render system.
- Purely additive and admin-gated — no user-facing input is involved.
