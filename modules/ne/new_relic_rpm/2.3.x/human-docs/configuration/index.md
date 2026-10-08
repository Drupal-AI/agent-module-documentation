# Configuration

All of New Relic RPM's behavior lives in one settings form, saved as the
exportable `new_relic_rpm.settings` config. A second tab lets you create a
deployment marker from the UI.

## Open the settings form

1. Log in as a user with the **Administer New Relic RPM** permission.
2. Go to **Configuration → Development → New Relic**, or navigate directly to
   `/admin/config/development/new-relic`.

## The settings, field by field

### API key and region

- **API key** — your New Relic REST API v2 key. It is used only for creating
  deployment markers and listing applications; leave it empty if you don't need
  deployment markers. (Transaction data does not use this — it flows through the
  PHP extension.)
- **Region** — which New Relic data center to reach for REST API calls: **US**
  (default, `https://api.newrelic.com/v2/`) or **EU**
  (`https://api.eu.newrelic.com/v2/`). Pick the one your New Relic account lives
  in; an EU account will not work against the US endpoint.

### Transaction tracking

Each of these accepts one of three modes: **Normal** (`norm`), **Background**
(`bg`), or **Ignore** (`ignore`).

- **Track Drush** (default Normal) — how Drush command runs appear in APM. Set to
  Background or Ignore to keep CLI runs out of your web throughput stats.
- **Track cron** (default Normal) — the same choice for cron runs.

### URL and role filters

- **Ignore URLs** — one path per line; matching requests are ignored in APM. Add
  health-check and monitoring endpoints here to cut noise. Supports `*` wildcards
  and `<front>`.
- **Background URLs** — one path per line; matching requests are marked as
  background jobs rather than web transactions.
- **Exclusive URLs** — one path per line; when this is non-empty, everything
  **not** listed is ignored. Handy for temporarily focusing APM on a single path
  you're debugging.
- **Ignore roles** — any user holding one of the selected roles has their
  transactions ignored (for example an uptime-monitor account).

### Error and log forwarding

- **Override exception handler** (default off) — route uncaught PHP exceptions to
  New Relic.
- **Watchdog severities** — the log levels (error, critical, etc.) whose watchdog
  messages should be forwarded to New Relic as errors. Leave empty to forward
  none.

### Views (slow render logging)

- **Log slow views** (default off) — record slow Views renders as `SlowView`
  custom Insights events.
- **Slow view threshold (ms)** (default 100) — the millisecond threshold above
  which a view counts as slow. Only used when "Log slow views" is on.

### Automatic deployment markers

- **Module deployment** (default off) — automatically create a deployment marker
  whenever a module is installed or uninstalled.
- **Config import** (default off) — automatically create a deployment marker
  whenever configuration is imported.

### Real User Monitoring

- **Disable AutoRUM** (default off) — turn off New Relic's automatic Real User
  Monitoring JavaScript injection site-wide.

Click **Save configuration** when done.

## Deployment markers

Deployment markers place a vertical line on your New Relic timeline so you can see
when releases happened. They require a valid **API key** (above), the correct
**Region**, and a resolvable application name (from the PHP extension's
`newrelic.appname`).

### From the UI

Use the **Deploy** tab at `/admin/config/development/new-relic/deploy` to create a
marker by hand. This needs the *Create New Relic RPM deployments* permission.

### From the command line

The module ships a Drush command, ideal for a release script:

```bash
drush nrd 1.2.3
drush nrd 1.2.3 --description="Release 1.2.3" --user="ci" --changelog="Fixed X, added Y"
```

The revision argument (here `1.2.3`) is the label shown on the New Relic timeline;
the three options are optional. If the API key is missing or the application name
can't be resolved (for example when the PHP extension isn't installed), the
command logs that the deployment failed.

## Reading and setting config from Drush

```bash
drush config:get new_relic_rpm.settings
drush config:set new_relic_rpm.settings region eu -y
drush config:set new_relic_rpm.settings track_drush ignore -y
drush config:set new_relic_rpm.settings views_log_slow true -y
```

(The list-type settings — ignored roles and watchdog severities — are best set
through the UI or a config import rather than a single scalar `config:set`.)
