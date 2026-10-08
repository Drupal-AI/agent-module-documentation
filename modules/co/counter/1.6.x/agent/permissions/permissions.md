# Permissions

Defined in `counter.permissions.yml`:

| permission | title | gates |
|------------|-------|-------|
| `administer counter` | Administer Counter | Every Counter admin route: `counter.counter_settings`, `counter.basic`, `counter.advanced`, `counter.initial`, `counter.dashboard`, `counter.statistics`, and the JSON `counter.statistics.data` endpoint. |

No `restrict access: true` flag is set, so grant it only to trusted roles — it exposes
visitor data (IPs, URLs, browsers) via the dashboard and statistics reports.

The `configurable_counter_block` display block instead gates on the core `access content`
permission; `counter_day_block` only renders for users with the `administrator` role. Placed
blocks otherwise follow normal block visibility.
