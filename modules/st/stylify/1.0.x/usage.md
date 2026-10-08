<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Stylify is an in-browser CSS editor that lets authorised users write custom stylesheets — scoped globally, per route, per entity, or per content type — and see them applied live.

---

Saved CSS is stored in the database (`StylesheetStorage`), validated (`CssValidator`), resolved to the current page context (`StylesheetResolver` distinguishing admin vs front-end), and injected via a `StylesheetAttachmentBuilder`. A persistent-lock manager (`StylifyLockManager` over `@lock.persistent` + keyvalue) prevents two editors clobbering the same sheet, exposed through check-lock/lock/unlock endpoints. All write and lock routes require one of the granular editor permissions AND a logged-in session AND a CSRF request-header token (`_csrf_request_header_token`); a `StylifyRequestGuard` adds flood control on top. Admin management (list/edit/delete/import/export) lives under `/admin/config/system/stylify/stylesheets` behind `manage stylify settings`.

Because saved CSS is served to end users, every permission is marked `restrict access: true`: `edit global stylify css`, `edit admin stylify css`, `edit entity stylify css`, the break-glass `access stylify css editor`, and `manage stylify settings`. Grant them only to trusted administrators. Set up by enabling the module, granting the appropriate editor permission(s), and opening the editor on the page whose styles you want to change.
---
- Edit a site-wide global stylesheet from the browser
- Add CSS scoped to a single route/page
- Style one entity or an entire content type
- Preview CSS changes live before saving
- Maintain separate admin-area CSS
- Lock a stylesheet while editing to avoid conflicts
- Release a stale edit lock
- Export a single stylesheet
- Export all stylesheets at once
- Import stylesheets from a file
- Delete a saved stylesheet
- Validate CSS before it is stored
- Restrict CSS editing to trusted roles via granular permissions
- Use the break-glass editor permission for emergency full access
- Apply flood/rate protection to save requests
- Serve custom CSS only on matching pages
- Keep front-end and admin CSS concerns separate
- Quickly patch a styling bug without a theme deploy
- Manage all saved sheets from one admin list
- Require CSRF tokens on every CSS write
