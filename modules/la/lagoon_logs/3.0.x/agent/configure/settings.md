<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration

Config object `lagoon_logs.settings` (schema `config/schema/lagoon_logs.schema.yml`,
defaults in `config/install/lagoon_logs.settings.yml`).

| Key | Type | Default | Meaning |
|---|---|---|---|
| `host` | string | `application-logs.lagoon.svc` | Logstash/UDP host to send logs to. |
| `port` | integer | `5140` | UDP port. |
| `identifier` | string | `drupal` | Leading Logstash identifier (application name). |
| `disable` | integer | `0` | `1` suppresses all log shipping. |

## Configure route / UI

Route `lagoon_logs.settings` → `/admin/config/development/lagoon_logs` (menu:
*Configuration → Development → Lagoon Logs settings*), requires the core permission
`administer site configuration`. The form is deliberately minimal — it exposes **only** the
**Disable module** checkbox and renders the current host/port/identifier as read-only text for
troubleshooting. Change host/port/identifier via config (below), not the form.

## Read / set via drush

```bash
drush cget lagoon_logs.settings
drush cset lagoon_logs.settings disable 1 -y
drush cset lagoon_logs.settings host logs.example.net -y
drush cset lagoon_logs.settings port 5544 -y
```

Or in PHP:

```php
\Drupal::configFactory()->getEditable('lagoon_logs.settings')
  ->set('host', 'logs.example.net')
  ->set('port', 5544)
  ->save();
```

## Environment variables (the record "host"/system name)

The per-record system name (the Logstash `host` field) is the **full identifier**, built in
`LagoonLogsLoggerFactory::getHostProcessIndex()`:

```
getenv('LAGOON_PROJECT')          ?: 'project_unset'
'-'
getenv('LAGOON_GIT_SAFE_BRANCH')  ?: 'safe_branch_unset'
```

On the Lagoon platform these env vars are set automatically, so logs from each project and branch are
distinguishable. When `disable` is truthy the identifier is `FALSE` and the logger sends nothing.
The defaults are intended to work unchanged inside Lagoon — hence "zero configuration".
