<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Page Expiration Testing (ape_test) — agent index

Test-only submodule of **ape**. Registers five routes (controller `ApeTestController`) so
tests can assert the `Cache-Control` header APE sets for redirects, alternative pages and
excluded pages. **No config, permissions, services, schema, or hooks** — just routing + a
controller. Enable it only in test/dev.

Endpoints (all `_access: 'TRUE'`):

| Path | Route | Behaviour |
|---|---|---|
| `/ape_redirect_301` | `ape.redirect.301` | 301 redirect → `/ape_redirect_landing` |
| `/ape_redirect_302` | `ape.redirect.302` | 302 redirect → `/ape_redirect_landing` |
| `/ape_redirect_landing` | `ape.redirect.landing` | renders "Arrived at your final destination." |
| `/ape_alternative` | `ape.alternative` | same landing content (add to APE `alternatives`) |
| `/ape_exclude` | `ape.exclude` | same landing content (add to APE `exclusions`) |

No solution docs are needed beyond this: there is no configurable/API surface. For the actual
cache-header logic these endpoints exercise, see the parent `ape` docs (`agent/api/behavior-and-hook.md`).
Ships disabled; enable with `drush en ape_test -y`.
