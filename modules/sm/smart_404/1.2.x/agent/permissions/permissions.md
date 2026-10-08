<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Smart 404 — permissions

From `smart_404.permissions.yml`. All four are `restrict access: true`.

| Permission | Gates |
|---|---|
| `view smart_404 log` | The overview (`smart_404.overview`) and detail (`smart_404.detail`) pages, read-only. |
| `manage smart_404 log` | Ignore/delete actions. **Also requires `view smart_404 log`.** |
| `create smart_404 redirects` | Redirect creation from the log. **Also requires `view smart_404 log`.** |
| `administer smart_404 settings` | The settings form and the ignore-patterns forms. |

## How routes enforce them (`smart_404.routing.yml`)

- `smart_404.overview`, `smart_404.detail` → `view smart_404 log`.
- `smart_404.ignore_single` → `view smart_404 log,manage smart_404 log` (comma = AND) **plus**
  `_csrf_token: 'TRUE'` (this is the one state-changing GET action).
- `smart_404.redirect_form`, `smart_404.bulk_redirect` → `view smart_404 log,create smart_404 redirects`.
- `smart_404.settings`, `smart_404.ignore`, `smart_404.ignore_confirm` → `administer smart_404 settings`.

`Smart404OverviewForm::submitForm()` re-checks the relevant permission for each bulk action and throws
`AccessDeniedHttpException` if missing (the bulk options are also only offered when permitted).

## Why `create smart_404 redirects` need not imply "administer redirects"

A holder can only ever create a **301/302 redirect to a validated internal path**
(`RedirectDestinationValidator::isValidInternalPath()`) from a source that is re-checked to still be a
live 404 at creation time (`Smart404RedirectCreator::validate()`'s `source_resolves` check). Off-site
destinations, non-301/302 codes, and redirecting a path that now resolves are all refused, so the
permission is safe to delegate without the Redirect module's broader administration permission. The
`source_resolves` check is best-effort (routing-table probe, current admin language, host `localhost`),
so a source that only 404s under a specific query string/Accept header or on another domain may slip
through — documented in the module README, and still bounded to internal 301/302 redirects.

## Upgrade backfills

`smart_404_update_10103` grants `manage smart_404 log` to roles that already had `view smart_404 log`,
and `10104` grants `view smart_404 log` to roles that had `create smart_404 redirects`, so no role
loses reach after the routing requirements were tightened.
