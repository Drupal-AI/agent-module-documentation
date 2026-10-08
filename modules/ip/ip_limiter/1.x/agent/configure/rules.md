<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — rules (ip_limiter.settings)

All configuration lives in the config object **`ip_limiter.settings`**, whose only key is **`rules`**
(a sequence of rule mappings). Install default is `rules: []`. Edited via the settings form
`Drupal\ip_limiter\Form\IpLimiterSettingsForm` (route `ip_limiter.settings`, path
`/admin/config/system/ip-limiter`, gated by permission `administer ip limiter configuration`). The
form is a `ConfigFormBase` with an AJAX add/edit/delete rule table (state kept in
`$form_state->get('rules_data')`; on submit each rule gets a sequential string `id`).

## Rule mapping — keys written to `ip_limiter.settings:rules[]`
Common to all plugins (see `IpLimiterSettingsForm::extractRuleValues()`,
`IpLimiterRuleManager::getConfiguredRules()`):

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `id` | string | seq | Instance id (assigned on save). |
| `plugin_id` | string | — | `path`, `route`, or `user_agent`. |
| `description` | string | '' | Required in the form; shown in the summary table. |
| `response_type` | int | `403` | HTTP status returned on deny: `403`/`404`/`429`. |
| `ban_duration` | int | `300` | Base ban length in seconds (`#min` 1). |
| `time_period` | int | `60` | Rolling window in seconds for counting requests (`#min` 1). |
| `max_requests` | int | `10` | Requests in the window before a ban (`#min` 1). Ban fires when count **>= max_requests**. |
| `global_restrict` | bool | `FALSE` | If TRUE the IP's ban is checked on **every** request, not only matching ones (see events doc). |

Note: the schema (`config/schema/ip_limitter.schema.yml`) types `ban_duration`/`time_period`/
`max_requests` as `string`, but the form and rule manager cast them to `int`. `response_type` is
schema `integer`.

### Path / Route rules (`plugin_id` = `path` or `route`)
| Key | Type | Meaning |
|-----|------|---------|
| `condition` | string | One entry per line. Path rule: request path **without leading slash** (e.g. `node/1`). Route rule: Symfony route name (e.g. `entity.node.canonical`). |
| `regex` | bool | When TRUE each line is a regex fragment, matched as `@preg_match('{' . $line . '}', $subject)`; when FALSE it is an exact `in_array()` compare. |
| `matcher_conditions` | mapping | Extra constraints ANDed on top of the primary match (below). |

`matcher_conditions` mapping:
- `user_agent_filter` — `null`, `'exclude_bots'` (rule applies only to non-bots), or `'block_bots'`
  (rule applies only to bots). "Bot" = matches the `common_bots` preset OR an empty UA. Form default
  is `exclude_bots`.
- `query_param_pattern` — a full regex (with delimiters, e.g. `/^q=[a-z0-9]/`) matched against
  `Request::getQueryString()`; `null`/empty = no filter.
- `require_referer` — bool; when TRUE the rule applies only if a non-empty `Referer` header is present.

### User-Agent rule (`plugin_id` = `user_agent`)
`condition`/`regex`/`matcher_conditions` are not used. Instead:

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `matcher_strategy` | string | `blacklist` | `blacklist` = block requests whose UA matches; `whitelist` = block requests whose UA does **not** match. |
| `use_presets` | bool | `FALSE`* | Include built-in presets in the pattern set. |
| `presets` | sequence of string | `['common_bots']`* | Preset ids to include (see `plugins/rules.md` for the full list). |
| `custom_patterns` | string | '' | One regex fragment per line; all fragments (+ selected presets) are OR-joined and matched `{...}i` (case-insensitive) against the UA. |

*Form defaults differ from stored defaults: the edit form defaults `use_presets` to TRUE and presets
to `['common_bots']`; `extractRuleValues()` and the rule manager default `use_presets` to FALSE when
absent.

## Response type — enforcement
`response_type` maps directly to the HTTP status of the bare `Response` returned by
`IpLimiterSubscriber::denyAccess()`: 403 → body "Access denied", 404 → "Page not found", 429 → "Too
many requests" (constants `RESPONSE_TYPE_403|404|429`).

## Legacy migration (update hooks)
Earlier versions (≤ alpha2) used flat config keys. `ip_limiter.install`:
- **`ip_limiter_update_10000`** — migrates legacy `blocked_paths`/`blocked_routes` (plus
  `response_type`/`ban_duration`/`time_period`/`max_requests`/`global_restrict`) into one `path` and/or
  one `route` rule under `rules`, then clears the legacy keys via `_ip_limiter_clear_legacy_keys()`.
  Skips if `rules` already populated.
- **`ip_limiter_update_10001`** — adds the `user_agent` and `referer` columns to `ip_limiter_ban`.

## Programmatic config example
```php
\Drupal::configFactory()->getEditable('ip_limiter.settings')
  ->set('rules', [[
    'id' => '1',
    'plugin_id' => 'path',
    'description' => 'Throttle search',
    'condition' => "search\nsearch/node",
    'regex' => FALSE,
    'response_type' => 429,
    'ban_duration' => 300,
    'time_period' => 60,
    'max_requests' => 20,
    'global_restrict' => FALSE,
    'matcher_conditions' => [
      'user_agent_filter' => NULL,
      'query_param_pattern' => NULL,
      'require_referer' => FALSE,
    ],
  ]])
  ->save();
```
Config changes take effect on the next request (the subscriber reads `ip_limiter.settings` live per
request; the plugin definitions are cached under `ip_limiter_rule_plugins`).
