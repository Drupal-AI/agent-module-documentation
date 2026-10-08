<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Autoban rules (config entity) & global settings

## The `autoban` config entity (one per rule)

Config name: `autoban.autoban.<id>`. Entity type id `autoban` (a `ConfigEntityType`,
`admin_permission = administer autoban`). `config_export` keys — these are the full stored
schema (`config/schema/autoban.schema.yml → autoban.autoban.*`):

| Key | Type | Meaning |
|---|---|---|
| `id` | string | Rule machine id. |
| `type` | string | dblog **log type/channel** to scan (the watchdog `type`), e.g. `page not found`, `access denied`, `user`. |
| `message` | string | Pattern the log **message** must match. |
| `referer` | string | Optional pattern the referring-URL must match. |
| `threshold` | int | Ban the IP once it has at least this many matching entries in the window. |
| `window` | string | Relative time window of log entries to consider, e.g. `1 hour`, `1 day` (empty = all). |
| `provider` | string | Ban-provider **id** to execute the ban (`ban`, `advban`, `advban_range`, …). See [../plugins/ban-providers.md](../plugins/ban-providers.md). |
| `user_type` | int | Which users to count: see constants below. |
| `rule_type` | int | `1` = manual, `2` = automatic (from Analyze). Constants in `AutobanUtils`. |

`user_type` (`Drupal\autoban\AutobanUtils`): `AUTOBAN_USER_ANY = 0`,
`AUTOBAN_USER_ANONYMOUS = 1`, `AUTOBAN_USER_AUTHENTICATED = 2`,
`AUTOBAN_USER_ANONYMOUS_STRICT = 3`, `AUTOBAN_USER_AUTHENTICATED_STRICT = 4`.
`rule_type`: `AUTOBAN_RULE_MANUAL = 1`, `AUTOBAN_RULE_AUTO = 2`.

### Create / read a rule with drush

```php
$storage = \Drupal::entityTypeManager()->getStorage('autoban');
$storage->create([
  'id' => 'ban_404_scanners',
  'type' => 'page not found',
  'message' => 'wp-login',
  'referer' => '',
  'threshold' => 5,
  'window' => '1 hour',
  'provider' => 'ban',
  'user_type' => 0,
  'rule_type' => 1,
])->save();
```
Read it back: `drush cget autoban.autoban.ban_404_scanners` (or
`$storage->load('ban_404_scanners')->provider`). Delete: `$entity->delete()`.

### UI

Rules list: `/admin/config/people/autoban` (route `entity.autoban.list`). Add:
`/admin/config/people/autoban/add/{rule}`. Edit/Delete under `.../manage/{autoban}`. The
**Test** page (`.../manage/{rule}/test`) previews which IPs a rule would ban; **Analyze**
(`.../analyze`) suggests rules from current log noise; **Delete all** wipes every rule.

## Global settings — `autoban.settings`

Configure form: route `autoban.settings` at `/admin/config/people/autoban/settings`. Keys
(`config/schema/autoban.schema.yml → autoban.settings`):

| Key | Type | Purpose |
|---|---|---|
| `autoban_thresholds` | string | Option list offered for a rule's threshold field. |
| `autoban_windows` | string | Option list of relative time windows. |
| `autoban_window_default` | string | Default window pre-filled on new rules. |
| `autoban_query_mode` | string | `LIKE` or `REGEXP` — how `message`/`referer` patterns match. |
| `autoban_use_wildcards` | bool | If FALSE, Autoban auto-appends wildcards to message patterns. |
| `autoban_whitelist` | string | IPs that must never be banned. |
| `autoban_dblog_type_exclude` | string | dblog types excluded from Analyze. |
| `autoban_threshold_analyze` | int | Threshold used on the Analyze page. |
| `autoban_cron` | bool | Run rules on cron (default TRUE — see `autoban_cron()`). |
| `autoban_force_mode` | bool | Evaluate rules on **every request**. |
| `autoban_debug` | bool | Log what each rule query matched. |
| `autoban_threshold_last` / `autoban_window_last` / `autoban_provider_last` | int/string | Remember last-used values for the Add form. |

Read/write: `drush cget autoban.settings autoban_query_mode` /
`drush cset autoban.settings autoban_query_mode REGEXP -y`.

## When rules run

- **Cron**: `autoban_cron()` runs every rule via `AutobanBatch::ipBan()` unless
  `autoban_cron` is FALSE.
- **Force mode**: `autoban_force_mode` evaluates rules per request (event subscriber).
- **Manually**: the rules-list "Ban all" action, a rule's Ban screen, or `drush autoban:ban`
  (see [../drush/ban.md](../drush/ban.md)).
