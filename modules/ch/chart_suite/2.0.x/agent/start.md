<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# chart_suite — agent orientation

- File-field formatters that chart uploaded data files (tables/trees/graphs); vendored SDSC StructuredData parser under `src/SDSC/`.
- Deps: field, file, system, jquery_ui_dialog, jquery_ui_menu. Admin route `/admin/config/media/chart_suite` uses permission literally named `admin`.
- `file_get_contents` calls operate on already-uploaded managed local files, not request URLs — no SSRF. No anon/mutation endpoints.
- Rendering client-side; nothing security-sensitive found.
