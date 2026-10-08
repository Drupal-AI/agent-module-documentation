<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# YASM (yasm) — agent index

Read-only **site statistics** suite under `/admin/reports/yasm`. Version **2.3.x**, package
`statistics`, core `^10.3 || ^11 || ^12`, PHP `^8.1`, license GPL-2.0-or-later. Core deps:
`datetime`, `user`. Optional integrations detected at runtime: `node`, `comment`, `file`, `media`,
`taxonomy`, `group` (1.x–4.x), `webform`, `statistics`, `language`, `views`, `markdown`.
Submodules: **`yasm_blocks`** (count blocks), **`yasm_charts`** (charts). No config schema ships;
the settings form writes the `yasm.settings` config object.

## What it provides

- **Dashboards / reports (routes, all `_admin_route`)** — every route is gated by its own
  `restrict access: TRUE` permission (see [config/permissions-and-routes.md](config/permissions-and-routes.md)):
  - Site: `/admin/reports/yasm/site-summary` (`Dashboard::siteContent`), `.../site-contents`
    (`Contents`), `.../site-users` (`Users`), `.../site-files` (`Files`), `.../site-entities`
    (`Entities`), `.../site-groups` (`Groups`), `.../site-taxonomies` (`Taxonomies`),
    `.../site-comments` (`Comments`).
  - My: `/admin/reports/yasm/my-summary` (`Dashboard::myContent`), `.../my-contents`,
    `.../my-comments`, `.../my-files` (`MyFiles`), `.../my-groups`.
  - Reports: `.../report-yearly` (`YearlyReport`), `.../report-monthly` (`MonthlyReport`).
  - Timeline: `.../timeline` (`Timeline::page`) + JSON `.../timeline/data` (`Timeline::data`).
  - Settings: `.../settings` (`YasmSettingsForm`).
- **Services** (`yasm.services.yml`): `yasm.builder` (render-array helpers), `yasm.entities_statistics`
  (entity-query counts/aggregates), `yasm.users_statistics`, `yasm.groups_statistics`,
  `yasm.datatables` (locale lookup), `yasm.group_version_manager` + static `GroupVersionHelper`
  (Group 1.x–4.x abstraction), `yasm.report_mailer`. Controllers are also registered as services.
- **Hooks** (`Hook\YasmHooks`, OOP `#[Hook]` + `#[LegacyHook]` shims in `yasm.module`):
  `theme` (7 templates), `help` (renders README), `views_data_alter` (adds `yasm_*_count` fields),
  `menu_local_tasks_alter` (hides sub-route tabs), `cron` + `mail` + `mail_alter` (scheduled report
  emails). Config override `Mail\YasmMailConfigOverride` routes `yasm` mail through `yasm_html_mail`.
- **Plugins**: mail `yasm_html_mail` (`Plugin\Mail\YasmHtmlMail`), Views field `yasm_entity_count`
  (`Plugin\views\field\NodeTypeNodeCount`). Report/data model constants in `YasmEntityDefinitions`.
- **17 permissions** (`yasm.permissions.yml`) and a `yasm.settings` config object (no schema file).

## Solution docs

- **Routes, permissions, tabs, page structure** → [config/permissions-and-routes.md](config/permissions-and-routes.md)
- **Statistics services / data model / how counts are gathered** → [api/statistics-services.md](api/statistics-services.md)
- **Settings form, scheduled report emails, HTML mail plugin** → [config/settings-and-mail.md](config/settings-and-mail.md)
- **Group compatibility layer, timeline, Views count field** → [api/integrations.md](api/integrations.md)
- **Submodules**: [`yasm_blocks`](../../modules/yasm_blocks/2.3.x/agent/start.md) ·
  [`yasm_charts`](../../modules/yasm_charts/2.3.x/agent/start.md)
