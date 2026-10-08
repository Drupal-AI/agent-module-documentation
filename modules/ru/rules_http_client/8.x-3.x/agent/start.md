<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rules HTTP Client (rules_http_client) — agent index

One Rules action that makes a server-side HTTP request (GET/POST/PUT/DELETE/…) to a URL and
exposes the response body back to the Rule. Version **8.x-3.2** (version dir `8.x-3.x`).
Core `^10.3 || ^11`. Package "Rules".

## Depends on
- `drupal/rules` (`^4.0`) — the action is a `@RulesAction` plugin consumed by Rules.
- Uses core's shared `http_client` (Guzzle) service; no other libraries.

## What it provides
- **RulesAction plugin** `rules_http_client` ("Request HTTP data", category "Data") —
  `src/Plugin/RulesAction/RulesHttpClient.php`. Context: `url` (required, multiple), `headers`,
  `method`, `data` (multiple), `max_redirects` (default 3), `timeout` (default 30), `debug`
  (default false). Provides `http_response` (string).
- **Settings form** `Drupal\rules_http_client\Form\SettingsForm` at route
  `rules_http_client.settings` → `/admin/config/workflow/rules/http-client-settings`
  (permission `administer rules`). Config object `rules_http_client.settings`
  (`show_responses` bool, `max_response_size` int).
- **Menu/task links** under the Rules reactions UI (`links.menu.yml`, `links.task.yml`).
- No custom entities, permissions, services, hooks, or Drush commands.

## Solution docs
- [Plugin: Request HTTP data action](plugins/rules_http_client_action.md) — context inputs,
  execution flow, response handling, debug logging.
- [Config: settings form](config/settings.md) — config object, schema keys, route/permission.
