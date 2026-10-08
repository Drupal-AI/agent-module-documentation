# Configuration

Lagoon Logs is built to run on its defaults, so there is very little to configure.
Everything lives in a single config object, `lagoon_logs.settings`, with four
values.

## The settings

| Setting | Default | What it does |
|---|---|---|
| **Host** | `application-logs.lagoon.svc` | The Logstash/UDP host that logs are sent to. On Lagoon this in‑cluster address is already correct. |
| **Port** | `5140` | The UDP port on that host. |
| **Identifier** | `drupal` | The leading Logstash identifier — the application name your logs are tagged with. |
| **Disable** | off (`0`) | When switched on, all log shipping is suppressed and nothing is sent. |

## The settings form

Open **Configuration → Development → Lagoon Logs settings**
(`/admin/config/development/lagoon_logs`). You need the core **Administer site
configuration** permission.

The form is intentionally minimal. It only lets you toggle the **Disable module**
checkbox, and it shows the current host, port, and identifier as **read‑only** text.
That read‑only display is there so you can verify the effective settings when
troubleshooting missing logs. Because the defaults are meant to work unchanged
inside Lagoon, the form doesn't offer to edit host/port/identifier directly.

## Changing host, port, or identifier

To point logs at a different collector (for example a self‑hosted Logstash, or when
you're not running on Lagoon), change the values in configuration rather than on the
form. With Drush:

```bash
drush cget lagoon_logs.settings              # see current values
drush cset lagoon_logs.settings host logs.example.net -y
drush cset lagoon_logs.settings port 5544 -y
drush cset lagoon_logs.settings disable 1 -y # pause log shipping
```

You can also export `lagoon_logs.settings` with the rest of your site
configuration so log routing is part of your deployment.

## How records are tagged (Lagoon environment variables)

Each log record's system name — the Logstash `host` field — is built from two
Lagoon environment variables joined by a dash:

- `LAGOON_PROJECT` (falls back to `project_unset` if not set)
- `LAGOON_GIT_SAFE_BRANCH` (falls back to `safe_branch_unset`)

On the Lagoon platform these are set automatically, so logs from each project and
branch are easy to tell apart in the aggregator. Off Lagoon, where the variables
aren't present, records fall back to those `*_unset` placeholders.
