# Auto Unban — Drush commands

Service `auto_unban.ban.commands` (`Drupal\auto_unban\Commands\BanCommands`), args
`@ban.ip_manager @datetime.time @date.formatter`.

| Command | Alias | Args / options | Does |
|---|---|---|---|
| `auto_unban:ban <ip>` | `ban` | `--permanent` | Bans an IP via `banIp()`. With `--permanent`, passes `attempts = 16` so the exponential window is effectively permanent (stops short of the 2038 int overflow). Without it, a normal time-limited ban. |
| `auto_unban:unban <ip>` | `unban` | — | `unbanIp($ip)` (sets `expires = 0`). |
| `auto_unban:banned` | `banned` | `--limit=N`, `--sort=expires\|attempts`, `--ip=<ip>`, `--all` | Prints banned rows as **JSON**. Default returns only un-expired rows (`expires >= now`); `--all` includes expired ones and adds an `expired` bool. Each row gains `expiresFormatted` (via `date.formatter`). Sort defaults to `attempts DESC`. |

Examples:
```
drush ban 203.0.113.5
drush ban 203.0.113.5 --permanent
drush unban 203.0.113.5
drush banned --all --sort=expires --limit=20
```
