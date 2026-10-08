<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# apptiles

Generates browserconfig.xml + app-tile/icon head metadata from theme settings.

- Service `apptiles` = `AppTilesManager` (config.factory, theme_handler, cache.default, router.admin_context, file_system).
- Reads bundled `browserconfig.xml` template via `simplexml_load_string(file_get_contents(__DIR__ ...))` (static local file, not user input).
- Config via `system.theme_settings`. Cached; skipped on admin routes. No permissions/mutation routes.

See [../usage.md](../usage.md).
