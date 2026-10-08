<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CrowdSec configuration (`crowdsec.settings`)

Single config object `crowdsec.settings` (schema is `FullyValidatable`). Form:
`Drupal\crowdsec\Form\Settings` at `/admin/config/services/crowdsec` (route `crowdsec.settings`,
permission `administer site configuration`). Menu under *Configuration → Web services*.

## Keys (with shipped defaults from `config/install/crowdsec.settings.yml`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `log_level` | int 0-7 (RFC 5424) | `5` (notice) | module log verbosity |
| `env` | `dev` \| `prod` | `dev` | environment; **changing it resets the site's CrowdSec ID and loses history** |
| `api_timeout` | int (≥1; -1 disables) | `120` | seconds for upstream API calls; on timeout, cached data is used |
| `cti_api_key` | string | `''` | optional CrowdSec CTI (threat-intel) API key |
| `signal_scenarios` | string[] | `[drupal/core-ban, drupal/auth-bruteforce, drupal/4xx-scan]` | which local bans are reported upstream |
| `scenarios` | string[] | the 3 above + `crowdsecurity/http-*` list | upstream blocklists to download & enforce (≥1 required) |
| `plugins.<id>` | mapping | see below | per ban-plugin settings |

`plugins` defaults:

```yaml
plugins:
  whisper:   { enable: true, ban_duration: 3600, leak_speed: 10, bucket_capacity: 10 }
  flood:     { enable: true, ban_duration: 3600 }
  core-ban:  { enable: true, ban_duration: 3600 }
```

Per-plugin sub-keys (schema is added dynamically in `CrowdsecHooks::configSchemaInfoAlter`):
`enable` (bool), `ban_duration` (int seconds). Buffered plugins (only `whisper`) also have
`leak_speed` (time window, seconds) and `bucket_capacity` (threshold count).

The setting key for a plugin is `plugins.<plugin_id>.<key>` — see
`ScenarioPluginBase::getSettingKey()`.

## Read / write with drush

```bash
drush cget crowdsec.settings                       # whole object
drush cget crowdsec.settings env                    # -> dev
drush cget crowdsec.settings plugins.whisper.ban_duration
drush cset crowdsec.settings env prod -y
drush cset crowdsec.settings plugins.flood.enable 0 -y
```

Or in PHP:

```php
\Drupal::configFactory()->getEditable('crowdsec.settings')
  ->set('plugins.whisper.bucket_capacity', 25)
  ->save();
```

## Signal vs subscribe (important mental model)

- **Ban plugins** (`plugins.<id>.enable`) control **local** bans on this site.
- **`signal_scenarios`** decides which of those local bans are additionally **reported upstream**.
  Disabling a signal only stops reporting; it does **not** disable the local ban plugin.
- **`scenarios`** decides which upstream CrowdSec blocklists are **downloaded and enforced** locally.

## Environment note

This documentation site has no live CrowdSec API/agent and no CTI key. Configuration reads/writes work
normally, but upstream operations (enroll, signal push, blocklist collect) will not reach CrowdSec.
