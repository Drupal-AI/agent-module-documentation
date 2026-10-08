<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — endpoint, access control, collectors

## The `/metrics` endpoint
- Route `prometheus_exporter.metrics`, path `/metrics`, defined dynamically in
  `Routing\Routes::routes()` (not a static `*.routing.yml` entry).
- Method: **GET only**. `_permission: 'access prometheus metrics'`. Option `_auth` is set to the
  full list of installed authentication providers, so `basic_auth`, `oauth2`, cookie, etc. all work.
- Controller `MetricsController::metrics()` runs every enabled collector, serializes each metric to
  the Prometheus exposition format, and returns `Content-Type: text/plain; version=0.0.4`, max-age 0.
  Collectors with no labelled values are skipped (no empty HELP/TYPE lines).

**Access is closed by default.** `access prometheus metrics` is granted to no role out of the box,
so `/metrics` returns 403 until you grant it. To open it to a scraper either grant the permission to a
role the scraper authenticates as, or enable the `prometheus_exporter_token_access` submodule (see its
docs — note its own default-open caveat). The README recommends fronting the endpoint with a firewall /
basic auth because metrics can disclose module versions and operational data.

## Settings form
- Route `prometheus_exporter.settings`, path `/admin/config/system/prometheus_exporter`,
  `_permission: 'administer prometheus exporter settings'`, form `Form\PrometheusExporterSettings`.
- Lists every collector whose `applies()` is TRUE with: an **enable** checkbox, a **tabledrag weight**
  row (execution/display order), and a per-collector **settings** subform (vertical tabs).
- Saves to the editable config `prometheus_exporter.settings`.

## Config object `prometheus_exporter.settings`
Shape (schema in `config/schema/prometheus_exporter.schema.yml`):
```yaml
collectors:
  <collector_id>:
    id: <collector_id>
    provider: prometheus_exporter        # or the submodule name
    enabled: false                       # default for ALL built-ins
    weight: 0
    settings: {}                         # collector-specific (see below)
```
Built-in collector ids and their `settings`:
| id | settings key(s) | notes |
|---|---|---|
| `user_count` | — | total users |
| `node_count` | `bundles` (sequence of node type ids) | count per selected bundle |
| `revision_count` | `bundles` | reuses node_count schema |
| `queue_size` | — | size of each queue |
| `active_user_count` | `seconds` (int, default 900) | users active in the window |
| `anonymous_session_count` | — | open anonymous sessions |
| `authenticated_session_count` | — | open authenticated sessions |
| `phpinfo` | — | PHP runtime info |

Enable a collector via Drush/config, e.g.:
```bash
ddev drush cset prometheus_exporter.settings collectors.user_count.enabled true -y
```

Then scrape:
```bash
curl -s https://site/metrics        # requires the permission / token
ddev drush prometheus:export        # same output, no HTTP, no permission check
```
