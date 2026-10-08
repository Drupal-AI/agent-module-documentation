<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Smart 404 (smart_404) — agent index

Logs every 404 response into an aggregated table and provides an admin UI to review logged paths and
create redirects (via the **Redirect** module) with alias-based destination suggestions. Package
**Administration**. Depends on `redirect:redirect`. Core `^10.3 || ^11`. PHP `>=8.1`. License
GPL-2.0-or-later. Version 1.2.0 (version-dir `1.2.x`).

## What it provides

- **No content entities or plugin types.** Two custom DB tables (`smart_404_log`,
  `smart_404_log_daily`, defined in `smart_404.install` `hook_schema()`), one config object
  (`smart_404.settings`), four permissions, three Drush commands, and a set of services.
- **Capture:** `Smart404Subscriber` (event subscriber) listens on `KernelEvents::RESPONSE` (priority
  -100) for any 404, and additionally on `KernelEvents::EXCEPTION` (priority 50) when the Search 404
  integration is on, delegating to `Smart404Logger::log()`.
- **Routes** (`smart_404.routing.yml`):
  - `/admin/reports/smart-404` (`smart_404.overview`) — the log overview form.
  - `/admin/reports/smart-404/{smart_404_id}` (`smart_404.detail`) — one path's detail + 30-day timeline.
  - `/admin/reports/smart-404/{smart_404_id}/ignore` (`smart_404.ignore_single`) — mark ignored;
    **GET with `_csrf_token: 'TRUE'`**.
  - `/admin/reports/smart-404/{smart_404_id}/redirect` (`smart_404.redirect_form`) — single redirect form.
  - `/admin/reports/smart-404/bulk-redirect` (`smart_404.bulk_redirect`) — bulk redirect form.
  - `/admin/config/system/smart-404` (`smart_404.settings`) + `/ignore` + `/ignore/confirm` — config.

## Solution docs

- **Settings, config object + schema, ignore patterns, retention & cron** →
  [configure/settings.md](configure/settings.md)
- **The 404 log UI, redirect creation flow, and the services/repository/suggestion engine** →
  [api/log-and-redirects.md](api/log-and-redirects.md)
- **The four permissions and what each route/action requires** →
  [permissions/permissions.md](permissions/permissions.md)
- **Drush commands (`smart404:list`, `smart404:cleanup`, `smart404:redirect`)** →
  [drush/commands.md](drush/commands.md)

## Notes

- Redirects are created only as **301/302 to a validated internal path** from a source re-checked to
  still be a live 404 — so `create smart_404 redirects` is safe to delegate without the Redirect
  module's own "administer redirects". See the two docs above.
- Privacy: no IP addresses or raw user-agent strings are stored; external referers are kept
  domain-only. Bot detection stores only a flag.
- Hooks live in an OOP class `Smart404Hooks` (`#[Hook(...)]`), with `#[LegacyHook]` shims in
  `smart_404.module` for core < 11.1: `help`, `cron`, `path_alias_insert/update/delete`,
  `runtime_requirements`.
