# Drush commands

Defined in `drush.services.yml` → `Drupal\flood_control\Commands\FloodUnblockCommands`
(backed by the `flood_control.flood_unblock_manager` service).

| Command | Args | Effect |
|---|---|---|
| `flood_unblock:ip <ip>` | IP address | Clears all flood events registered for that IP (across every flood event type). |
| `flood_unblock:all` | — | Clears every flood event in the system (all event types, all identifiers). |

Examples:
```
drush flood_unblock:ip 203.0.113.7
drush flood_unblock:all
```

Equivalent UI: the Flood unblock screen at `/admin/people/flood-unblock` lists blocked IPs
and user IDs with per-row clear actions. The underlying service
(`FloodUnblockManagerInterface`) exposes `getEvents()`, `getEventIds($event, $ip = NULL)`, and
`floodUnblockClearEvent($fid)` for custom code.
