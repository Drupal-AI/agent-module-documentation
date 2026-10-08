<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AnimateCSS UI — agent index

Admin UI for the base AnimateCSS module. Binds Animate.css animations to CSS selectors (stored in a DB table) and controls how/where the library loads. Depends on `animatecss`. All routes require the `administer animate css` permission.

- **Global settings, the per-selector animate records, DB table, routes, page-visibility, library method** → [configure/settings.md](configure/settings.md)

Parent module: [../../../../1.1.x/agent/start.md](../../../../1.1.x/agent/start.md)

Key facts:
- `configure` route `animatecss.admin` → `/admin/structure/animatecss` (list); global settings `animatecss.settings` → `/admin/config/user-interface/animatecss/settings`.
- Selector records live in custom table `animatecss` (schema in `animatecss_ui.install`), managed by service `animatecss.animate_manager` (`AnimateCssManager`).
- Config object `animatecss.settings` (owned by this submodule; schema here).
- When enabled, this submodule's `hook_page_attachments()` replaces the base module's library attachment (adds method/variant/compat + page-visibility logic) and emits enabled selectors to `drupalSettings.animatecss.elements`.
