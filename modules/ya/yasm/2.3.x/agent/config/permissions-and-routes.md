<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# YASM routes, permissions & navigation

## Install / enable

`composer require drupal/yasm` then `drush en yasm`. Enable `yasm_charts` and/or `yasm_blocks`
separately (each is an optional submodule). No install hook; nothing is created at enable time.

## Permissions (`yasm.permissions.yml`)

17 permissions, **every one `restrict access: TRUE`** (Drupal warns before granting). Each
dashboard/report route requires exactly one. Site-wide ("yasm summary/contents/users/files/entities/
groups/taxonomies/comments") expose aggregate site data; personal ("yasm my summary/contents/groups/
comments/files") expose only the current user's own data; "yasm report" covers both reports; "yasm
timeline" covers the timeline page and its data endpoint; "yasm settings" covers the settings form.
Grant site-wide + settings only to trusted staff roles; the "my …" set is safe for authenticated
users (each controller scopes queries to the current uid).

## Routes (`yasm.routing.yml`, all `options._admin_route: TRUE`)

| Path | Controller::method | Permission | Extra |
|------|--------------------|------------|-------|
| `/admin/reports/yasm` | `Dashboard::redirectToSite` | `yasm summary` | redirect to site-summary |
| `/admin/reports/yasm/site-summary` | `Dashboard::siteContent` | `yasm summary` | |
| `/admin/reports/yasm/site-contents` | `Contents::siteContent` | `yasm contents` | `_custom_access: Contents::access` |
| `/admin/reports/yasm/site-users` | `Users::siteContent` | `yasm users` | `_custom_access: Users::access` |
| `/admin/reports/yasm/site-files` | `Files::siteContent` | `yasm files` | `_custom_access: Files::access` |
| `/admin/reports/yasm/site-entities` | `Entities::siteContent` | `yasm entities` | |
| `/admin/reports/yasm/site-groups` | `Groups::siteContent` | `yasm groups` | `_custom_access: Groups::access` |
| `/admin/reports/yasm/site-taxonomies` | `Taxonomies::siteContent` | `yasm taxonomies` | `_custom_access` |
| `/admin/reports/yasm/site-comments` | `Comments::siteContent` | `yasm comments` | `_custom_access` |
| `/admin/reports/yasm/my-summary` | `Dashboard::myContent` | `yasm my summary` | |
| `/admin/reports/yasm/my-contents` | `Contents::myContent` | `yasm my contents` | `_custom_access` |
| `/admin/reports/yasm/my-comments` | `Comments::myContent` | `yasm my comments` | `_custom_access` |
| `/admin/reports/yasm/my-files` | `MyFiles::myContent` | `yasm my files` | `_custom_access` |
| `/admin/reports/yasm/my-groups` | `Groups::myContent` | `yasm my groups` | `_custom_access` |
| `/admin/reports/yasm/report-yearly` | `YearlyReport::page` | `yasm report` | |
| `/admin/reports/yasm/report-monthly` | `MonthlyReport::page` | `yasm report` | |
| `/admin/reports/yasm/timeline` | `Timeline::page` | `yasm timeline` | |
| `/admin/reports/yasm/timeline/data` | `Timeline::data` | `yasm timeline` | JSON (`CacheableJsonResponse`) |
| `/admin/reports/yasm/settings` | `YasmSettingsForm` | `yasm settings` | |

The `_custom_access` methods (e.g. `Contents::access`) additionally return `AccessResult::forbidden`
when the underlying module (node/comment/file/taxonomy/group) is disabled, so a granted permission
still 403s if the feature module is absent.

## Navigation (`yasm.links.menu.yml`, `yasm.links.task.yml`, `Hook\YasmHooks::menuLocalTasksAlter`)

- Admin-menu: a "Statistics" item under *Reports* with children Site / My / Timeline / Reports /
  Configuration.
- **Primary tabs** are only the 5 top routes (Site, My, Timeline, Reports, Settings). The many
  sub-routes are declared as tasks with empty titles (so Drupal keeps the parent tab active) and
  then removed from `$data['tabs'][0]` by `menuLocalTasksAlter()`. In-page navigation between
  sub-pages is rendered inside the content area via the `yasm_tabs` theme (built by
  `YasmBuilder::getSectionLinks()`, which also hides links the user cannot access or whose module
  is disabled).

## Config object

`yasm.settings` (keys `mail_monthly_enabled`, `mail_yearly_enabled`, `mail_recipients`) — written by
`YasmSettingsForm`. **No `config/schema` or `config/install` ships**; the object is created on first
save with the form's defaults. See [reports-and-mail.md](reports-and-mail.md).
