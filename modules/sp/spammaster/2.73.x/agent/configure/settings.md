# Configure Spam Master

All admin lives under `/admin/config/system/spammaster` as five local-task tabs, each a config
form gated by core `administer site configuration`:

| Route | Path | Form | Purpose |
|---|---|---|---|
| `spammaster.settings` | `/admin/config/system/spammaster` | `SpamMasterSettingsForm` | License key entry / status. |
| `spammaster.settings_protection` | `…/protection` | `SpamMasterProtectionForm` | Firewall, honeypot, flood control, cleanup, alerts. |
| `spammaster.settings_buffer` | `…/buffer` | `SpamMasterBufferForm` | The threats blacklist ("buffer"). |
| `spammaster.settings_white` | `…/white` | `SpamMasterWhiteForm` | Whitelist IPs / form-ids. |
| `spammaster.settings_log` | `…/log` | `SpamMasterLogForm` | Statistics & activity log. |

## Config objects

### `spammaster.settings`
| Key | Meaning |
|---|---|
| `license_key` | The Spam Master license key. Auto-generated random hash on install (FREE license); replace with a Pro key. Authenticates SaaS calls. |
| `subtype` | `prod` enables enforcement; any other value disables the firewall subscriber. Install sets `prod`. |

### `spammaster.settings_protection` (defaults from `hook_install`)
| Key | Default | Meaning |
|---|---|---|
| `block_message` | `Your Email, Domain, or Ip are banned.` | Message shown to banned actors. |
| `basic_firewall` | `1` | Master firewall on/off. |
| `basic_firewall_rules` | `1` | Rule strictness (`1` strict, `2` relaxed) — also gates the elusive/flood API call. |
| `extra_honeypot` | `1` | Enable bundled honeypot fields (`spammaster_extra_field_1/2`). |
| `flood_control` | `0` | Enable POST flood control. |
| `flood_control_window` | `5` | Flood window (seconds). |
| `flood_control_limit` | `3` | Max POSTs per window before block (HTTP 429). |
| `signature` | `0` | Show/hide Spam Master signature output. |
| `email_alert_3` | `1` | Email on alert level 3. |
| `email_daily_report` / `email_weekly_report` | `0` | Periodic email reports. |
| `email_improve` | `0` | Opt-in improvement emails. |
| `cleanup_firewall` / `cleanup_honeypot` / `cleanup_whitelist` / `cleanup_system` / `cleanup_mail` / `cleanup_cron` | `15` | Retention days per log category (cron cleanup). |
| `spam_master_is_cloudflare` | `0` | Use CDN/Cloudflare client-IP resolution. |

### `spammaster.settings_white`
| Key | Meaning |
|---|---|
| `white_key` | Whitelist entry input. |
| `white_selection` | Whitelist type selector. |

Config schema for all of the above ships in `config/schema/spammaster.schema.yml`. The buffer and
log forms mainly read/write the `spammaster_threats` / `spammaster_white` / `spammaster_keys`
tables rather than config.

## Quick toggles (Drush)

```bash
# Disable enforcement without uninstalling:
drush config:set spammaster.settings subtype dev -y
# Turn on flood control:
drush config:set spammaster.settings_protection spammaster.flood_control 1 -y
```

## Enforcement preconditions

Blocking happens only when license status is VALID/MALFUNCTION_1/MALFUNCTION_2 **and**
`subtype === 'prod'`. Admins (`administer site configuration` or `administer nodes`) and
whitelisted IP/form-id are always exempt. See [api/services.md](../api/services.md).
