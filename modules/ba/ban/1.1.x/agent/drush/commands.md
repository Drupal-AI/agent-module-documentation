# Ban — CLI commands

Ban ships four commands as **Symfony Console** commands (registered via `drush.services.yml` with
the `console.command` tag, classes in `src/Command/`). Per the README they run through the Drupal
CLI `dr` (Drupal 11.4+) or Drush (13.7+):

| Command | Argument | Does |
|---|---|---|
| `ban:ban <ip>` | required IP | Bans an IP. Validates the IP, refuses allowlisted IPs, warns if already banned. |
| `ban:unban <ip>` | required IP | Removes the ban for an IP. |
| `ban:list` | — | Lists all banned IPs (`iid`, `ip`) as a table; says so if none. |
| `ban:flush` | — | Removes all bans (calls `unbanAllIps()`). |

```bash
drush ban:ban 203.0.113.5      # or: dr ban:ban 203.0.113.5
drush ban:list
drush ban:unban 203.0.113.5
drush ban:flush
```

`ban:ban` returns failure for an invalid IP or an allowlisted IP (defined in
`$settings['ban_allowlist']`, see [../configure/settings.md](../configure/settings.md)) and
succeeds (with a warning) if the IP is already banned.

If your Drush/Drupal CLI version is older and does not pick these up, use the `ban.ip_manager`
service from `drush php:eval` instead (see [../api/manager.md](../api/manager.md)).
