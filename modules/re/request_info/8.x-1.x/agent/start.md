<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Request Info (request_info) — agent index

Tiny diagnostic module. Adds a block of current-request attributes to Drupal's status report
(`admin/reports/status`) so an administrator can see what request Drupal actually received behind a
reverse proxy, CDN or load balancer. Version **8.x-1.5**. Core `^8 || ^9 || ^10 || ^11`.

- **No dependencies**, no composer requirements, no submodules.
- **No routes, permissions, services, entities, plugins, config or config schema of its own.**
- Ships only two hook implementations, no `src/`:
  - `request_info_requirements($phase)` in `request_info.install` — on the `runtime` phase, emits
    one `REQUIREMENT_INFO` entry per request attribute onto the status report.
  - `request_info_help()` in `request_info.module` — the module's help text on
    `help.page.request_info`.

## What it displays

Client IP, base URL, trusted-proxy flag, secure flag, scheme, HTTP headers (dumped in a `<pre>`),
HTTP host, port, HTTP-auth user, protocol version, preferred language. See
[agent/api/status-report.md](api/status-report.md) for the exact attributes, how each is derived,
and the sanitising the hook performs.

## Install / operate

- Enable: `drush en request_info`. Nothing to configure.
- View: log in as an administrator and open **Reports → Status report** (`admin/reports/status`).
  The attributes appear as informational rows there. Access is governed entirely by core's status
  report page permission (`administer site configuration`); this module adds none.
