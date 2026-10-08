# Drush commands

Registered via `drush.services.yml` → `Drupal\feeds\Commands\FeedsDrushCommands`.
All take a numeric feed id (`fid`); import-all takes feed type ids.

| Command | Args / options | Does |
|---|---|---|
| `feeds:list-feeds` | — | List all feeds (id, type, title, source, state). |
| `feeds:import` | `<fid>` `--import-disabled` | Import a single feed now. |
| `feeds:import-all` | `<type…>` `--import-disabled` | Import every feed of the given feed type(s). |
| `feeds:enable` | `<fid>` | Enable (activate) a feed so it imports on cron. |
| `feeds:disable` | `<fid>` | Disable a feed. |
| `feeds:lock` | `<fid>` | Manually lock a feed (block concurrent imports). |
| `feeds:unlock` | `<fid>` | Clear a stuck lock left by a crashed/aborted import. |

```bash
drush feeds:list-feeds
drush feeds:import 3
drush feeds:import-all my_feed_type --import-disabled
drush feeds:unlock 3
```

`--import-disabled` forces import even when the feed is not active. Use these for cron jobs and
CI instead of the UI batch. For code-level control see [../api/import.md](../api/import.md).
