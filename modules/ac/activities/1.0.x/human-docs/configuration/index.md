# Configuration

Activities is configured on three admin forms, all of which write the single
`activities.settings` config object. Out of the box that config is **empty — so nothing
is logged** until you enable it.

## The forms at a glance

| Form | Path | Permission |
|------|------|------------|
| What to log | `/admin/config/activities` | `administer users activity` |
| Auto‑purge settings | `/admin/config/activities/purge` | `administer users activity` |
| Manual purge (one‑off) | `/admin/config/activities/purge/manual` | `purge activities` |

## Choose what to log

Open **Configuration → Activities** (`/admin/config/activities`). For each content entity
type you'll see checkboxes for the four operations — **Create**, **Update**, **Delete**,
**View** — plus an optional per‑bundle restriction. Tick the operations you want logged;
leave the bundle list empty to log all bundles, or select specific ones (e.g. only
"Article" and "Page" nodes).

> **Watch out for View logging.** Enabling **View** logs an entry on *every* page view of
> that entity type, which is heavy on a busy or public site. Turn it on deliberately, and
> use the security controls below.

## Security — protecting view tracking

Under the same form's **security** settings:

- **View throttle window** (`view_throttle_window`, default `60` seconds) — suppress
  duplicate view logs from the same user on the same entity within this many seconds. Set
  `0` to disable throttling.
- **Exclude anonymous users from view tracking** (`exclude_anonymous_views`, default on)
  — don't log views by anonymous visitors, which greatly reduces log spam and DoS surface
  on public sites.

## Purge — keeping the log a sensible size

Open the **Purge** form (`/admin/config/activities/purge`). The purge runs automatically
on **cron**:

- **Purge method** (`purge_method`, default *never*):
  - **Never** — keep everything (full retention).
  - **Time‑based** — delete entries older than a set age. Set **time value**
    (`time_value`, default `30`) and **time unit** (`time_unit`, default *days*), e.g.
    delete entries older than 90 days.
  - **Count‑based** — keep at most a maximum number of entries (`count_limit`, default
    `10000`); the oldest are deleted first.

For a one‑off cleanup, use the **manual purge** form
(`/admin/config/activities/purge/manual`), which requires the separate *purge activities*
permission.

## Setting values from the command line

```bash
# Log node create + delete (all bundles)
drush php:eval '$c=\Drupal::configFactory()->getEditable("activities.settings");
  $c->set("node", ["create"=>"create","update"=>0,"delete"=>"delete","view"=>0])->save();'

# Time-based purge: delete activities older than 90 days
drush php:eval '$c=\Drupal::configFactory()->getEditable("activities.settings");
  $c->set("purge", ["purge_method"=>"time_based","time_value"=>90,"time_unit"=>"days","count_limit"=>10000])->save();'

# Read current settings
drush config:get activities.settings
```

## Permissions

| Permission | Machine name | Gates |
|------------|--------------|-------|
| Can view users activity | `can view users activity` | Viewing the activity log / `user_activities` entities. |
| Administer users activity | `administer users activity` | The "what to log" and purge‑settings forms. |
| Purge activities | `purge activities` | The manual purge form (*restrict access*). |

## Viewing and exporting the log

The log is a `user_activities` entity exposed to **Views**, so you can build a listing
and filter it by acting user, entity type, operation, bundle, or date range, and see the
IP and location of each action. If you enabled the **Activity Data Export** submodule, it
adds a ready‑made Views page with **CSV / XLS export** of the log.

## Logging from code

Developers can log activity programmatically via the `activities.logger` service, and
alter an entry before it's saved with `hook_activities_logger_log()`. There are also
manager and purge services for reporting and cleanup. See the
[`agent/`](../agent/api/services.md) docs for details.
