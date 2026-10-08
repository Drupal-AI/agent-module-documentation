# Configuration

All of CrowdSec's settings live on one page: **Configuration → Web services →
CrowdSec** (`/admin/config/services/crowdsec`), which requires the *Administer site
configuration* permission. This page saves everything into a single `crowdsec.settings`
config object.

## General settings

| Setting | Default | What it does |
|---------|---------|--------------|
| **Log level** | 5 (notice) | How verbose the module's own logging is, on the RFC 5424 scale 0–7. Lower it for quieter production logs, raise it for debugging. |
| **Environment** | `dev` | `dev` or `prod`. Production optimises performance and reduces logging. **Changing this resets the site's CrowdSec identity and loses its history** — pick it deliberately. |
| **API timeout** | 120 | Seconds to wait on upstream API calls. If a call times out, the module falls back to its cached remediation decisions. (`-1` disables the timeout.) |
| **CTI API key** | *(empty)* | An optional CrowdSec threat-intelligence key that unlocks richer data about IP addresses. See "Supplying the API key" below. |

## Ban plugins (local bans)

The ban plugins decide what counts as bad behaviour on your own site and ban the IP
locally. Each has an **enable** toggle and a **ban duration** (seconds); the buffered
**whisper** plugin also has a time window (leak speed) and a threshold (bucket
capacity).

| Plugin | Detects | Notable settings |
|--------|---------|------------------|
| **whisper** | Too many 4xx responses in a window (scanning / probing). | enable, ban duration (default 3600s), leak speed (default 10s), bucket capacity (default 10). |
| **flood** | Drupal flood-control / login brute force. | enable, ban duration (default 3600s). |
| **core-ban** | IPs banned manually via core's Ban module. | enable, ban duration (default 3600s). |

Tune each plugin's duration, window and threshold to match how aggressive you want the
site to be.

## Signal vs subscribe — the mental model

This is the part that trips people up, so it's worth stating plainly:

- **Ban plugins** control **local** bans on this site.
- **Signal scenarios** decide which of those local bans are additionally **reported
  upstream** to CrowdSec. Disabling a signal only stops the *reporting* — the local
  ban still happens.
- **Subscribe scenarios** decide which upstream CrowdSec **blocklists** are
  **downloaded and enforced** locally (matching requests get a 403). At least one is
  required.

By default the module signals its three local detections upstream and subscribes to a
set of common CrowdSec HTTP-probing blocklists (SQL-injection probing, XSS probing,
path traversal, sensitive files, and more). Add or remove scenarios to match the
attack vectors you care about.

## Supplying the API key safely

The CTI API key is a secret — don't paste it into configuration that gets exported and
committed. Store it in an environment variable instead. With DDEV:

```bash
ddev dotenv set .ddev/.env --crowdsec-cti-api-key='YOUR_KEY'
ddev restart
```

Then reference the environment variable rather than hard-coding the value — for
example by overriding the setting in `settings.php`:

```php
$config['crowdsec.settings']['cti_api_key'] = getenv('CROWDSEC_CTI_API_KEY');
```

Never commit the key to version control.

## Reading and writing settings from the command line

Because everything is one config object, you can script it:

```bash
drush cget crowdsec.settings                       # the whole object
drush cget crowdsec.settings env                    # -> dev
drush cget crowdsec.settings plugins.whisper.ban_duration
drush cset crowdsec.settings env prod -y
drush cset crowdsec.settings plugins.flood.enable 0 -y
```

## Command-line operations

Several Drush commands cover the upstream side and testing:

- `drush crowdsec:enroll` — enrol the site into a CrowdSec console account.
- `drush crowdsec:signal` — flush buffered signals upstream now.
- `drush crowdsec:collect` — force a blocklist refresh.
- `drush crowdsec:test:signal` / `drush crowdsec:test:ip` — signal or verify a specific
  IP to test the integration.

Cron runs the signal push and blocklist refresh automatically, so day-to-day you don't
need to run these by hand.

> **Reminder:** the upstream commands (`enroll`, `signal`, `collect`) only succeed when
> the site can reach the CrowdSec service and, where required, has a valid API key.
> Local configuration and local bans work regardless.
