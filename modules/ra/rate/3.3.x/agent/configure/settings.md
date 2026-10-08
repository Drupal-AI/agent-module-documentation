<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Global settings & permissions

![Rate settings form](../../../../../../../screenshots/rate/3.3.x/settings.png)

## Global settings (`rate.settings`)

Form route `rate.admin_settings` at `/admin/config/search/votingapi/rate` (permission
`administer rate`). This is the module's `configure` route. Config object `rate.settings`:

| Key | Type | Purpose |
|---|---|---|
| `bot_minute_threshold` | string | max votes from one IP per minute before it is treated as a bot (default 25) |
| `bot_hour_threshold` | string | max votes from one IP per hour (default 250) |
| `botscout_key` | string | optional BotScout.com API key for IP reputation lookups |
| `disable_log` | boolean | when true, suppresses Rate's watchdog log messages |

```bash
drush cget rate.settings
drush cset rate.settings bot_minute_threshold 10 -y
drush cset rate.settings disable_log true -y
```

Bad user-agent patterns are **not** in config — they live in the `rate_bot_agent` DB table
(`%` = wildcard, case-insensitive, e.g. `%bot%`).

## Permissions

Static (`rate.permissions.yml`):

| Permission | Gates |
|---|---|
| `administer rate` | create/edit/delete widgets, settings form (admin roles only) |
| `view rate results page` | the per-node "Rate Voting results" tab (`/node/{node}/node-rating`) |

**Dynamic** (`RatePermissions::permissions`, `permission_callbacks`): for every bundle a
widget is attached to, a permission
`cast rate vote on <entity_type> of <bundle>` is generated (and
`cast rate vote on <comment_field> on <entity_type> of <bundle>` for comment widgets). A role
must hold the matching one to actually vote — new widgets grant nobody voting rights until you
set these. List them with:

```bash
drush role:perm:list authenticated | grep 'cast rate vote'
drush role:perm:add authenticated 'cast rate vote on node of article'
```
