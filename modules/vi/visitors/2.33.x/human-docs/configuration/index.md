# Configuration

Visitors starts logging as soon as it's enabled, but the settings form lets you decide
exactly what is tracked, how long logs are kept, and how the reports look.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → System → Visitors**, or navigate directly to
   `/admin/config/system/visitors`.

All values are stored in a single configuration object, **`visitors.config`** (note:
the *form route* is `visitors.settings`, but the *config object* is `visitors.config`).

## The settings, field by field

**Log retention**

- **Log retention timer** (`flush_log_timer`, default `0`) — how long, in seconds, to
  keep visit log rows. `0` means keep them forever. Old rows past this age are pruned on
  cron.
- **Bot log retention** (`bot_retention_log`, default `0`) — the same idea, but for
  logs identified as bot traffic.

**Reports display**

- **Items per page** (`items_per_page`, default `10`) — how many rows each report page
  lists.
- **Theme** (`theme`, default `admin`) — which theme the report pages render in.

**Tracking**

- **Disable tracking** (`disable_tracking`, default off) — a master switch to stop all
  tracking site‑wide without uninstalling the module. Handy for a maintenance window.
- **Track user ID** (`track.userid`, default on) — also record the logged‑in user's ID
  alongside anonymous visit data.
- **Script type** (`script_type`, default `minified`) — serve the minified tracker
  script, or the full (unminified) version, which is easier to debug.

**Content hit counter**

- **Counter enabled** (`counter.enabled`) — turn on the per‑content "N views" counter.
- **Counter entity types** (`counter.entity_types`, default `['node']`) — which entity
  types get a hit counter.
- **Counter cache lifetime** (`counter.display_max_age`, default `3600`) — how long, in
  seconds, a counter value is cached before it's recalculated, which keeps write load
  down on busy pages.

**Visibility — who and what gets tracked**

- **Request path mode / paths** (`visibility.request_path_mode`,
  `visibility.request_path_pages`) — mode `0` tracks everything *except* the listed
  paths (the default list excludes admin pages); mode `1` tracks *only* the listed
  paths.
- **Role rules** (`visibility.user_role_mode` / `user_role_roles`) — track (or exclude)
  visits from specific roles.
- **Account rule** (`visibility.user_account_mode`) — account‑based tracking rule.
- **Exclude user 1** (`visibility.exclude_user1`, default off) — keep the superuser out
  of the analytics.

## Reading and setting values from the command line

```bash
drush config:get visitors.config
drush config:set visitors.config items_per_page 25 -y
```

## Rebuild tools — reprocessing the existing log

Because Visitors stores the raw request data for each visit, it can recompute derived
fields for historic rows. This is useful after a URL/alias change or when you start
deriving something new. The forms are under the settings page:

- **Rebuild route** — `/admin/config/system/visitors/rebuild-route`
- **Rebuild IP address** — `/admin/config/system/visitors/rebuild-ip-address`
- **Rebuild device** — `/admin/config/system/visitors/rebuild-device`

The same work is available from Drush:

```bash
drush visitors:rebuild:route
drush visitors:rebuild:ip-address
drush visitors:rebuild:device
```

(The geolocation rebuild and MaxMind database download commands live in the **Visitors
GeoIP** submodule.)

## Permissions

Grant these at **People → Permissions**:

- **`access visitors`** — view the analytics reports under `/visitors`. This is the main
  "see the stats" permission.
- **`opt-out of visitors tracking`** — lets a user choose whether their own actions are
  tracked.
- **`view visitors counter`** — see the per‑content hit counter (the "N views" display).

The settings and rebuild admin pages additionally require core's *Administer site
configuration* permission.

## The reports

Under **`/visitors`** you'll find Recent hits, Top pages, Hosts, Referrers, and
device/browser/OS breakdowns, all built from the log with Views and drawn as Chart.js
charts. Because the data lives in a plain `visitors` database table, you can also build
your own custom Views on top of it.
