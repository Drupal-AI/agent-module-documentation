# Configuration

Spam Master's admin lives under **Configuration → System → Spam Master**
(`/admin/config/system/spammaster`) as five tabs, all gated by the core
**Administer site configuration** permission.

## The five admin tabs

| Tab | What it's for |
|-----|---------------|
| **Settings** | Enter/view your license key and see its status. Auto-filled with a free key on install; paste a Pro key here to upgrade. |
| **Protection Tools** | The main controls — firewall, honeypot, flood control, cleanup schedules, and email alerts (see below). |
| **Spam Buffer** | The local blacklist of threat IPs/emails that are blocked on every request. |
| **Whitelist** | Trusted IPs or specific form IDs that bypass all spam checks. |
| **Statistics & Log** | Spam statistics and an activity log of firewall blocks. |

## Key settings (Protection Tools)

You rarely need to change the defaults, but the settings worth knowing are:

- **Master firewall** *(on by default)* — the overall on/off switch for blocking.
- **Rule strictness** — strict (default) or relaxed; also affects the advanced
  "elusive bot" detection.
- **Honeypot** *(on by default)* — adds hidden trap fields to forms to catch bots.
- **Flood control** *(off by default)* — throttle rapid POST submissions. When on,
  more than the configured number of POSTs within the time window (defaults: 3
  posts per 5 seconds) gets an HTTP 429.
- **Block message** — the message shown to banned emails/domains/IPs.
- **Email alerts & reports** — email on a level-3 threat alert (on by default), plus
  optional daily/weekly summary reports.
- **Cleanup retention (days)** — how long each category of log is kept before cron
  cleans it (firewall, honeypot, whitelist, system, mail, cron logs — all default
  to 15 days).
- **Cloudflare / CDN mode** — turn on if your site sits behind Cloudflare, so the
  real client IP is resolved correctly.

## The license

A random **free** license key is generated and activated on install, so protection
works out of the box. To raise your volume/threat coverage, obtain a Pro key from
Spam Master and paste it on the **Settings** tab. The license key (together with the
rotating db-protection hash) is what authenticates all traffic between your site
and spammaster.org — treat it as a secret.

## Pausing protection quickly

If you need to switch the firewall off without uninstalling — for example while
debugging a false positive — flip the site's **subtype** away from `prod`.
Blocking only happens when the license is valid **and** the subtype is `prod`, so:

```bash
# Disable enforcement without uninstalling:
drush config:set spammaster.settings subtype dev -y
# ...and turn it back on later:
drush config:set spammaster.settings subtype prod -y
```

Administrators (users with *Administer site configuration* or *Administer nodes*)
and any whitelisted IP or form ID are always exempt from blocking, so you're
unlikely to lock yourself out.

## Good to know

- Blocking is enforced by a request-time firewall that runs on every request while
  active. Threats, logs, and whitelist rows are stored in the module's own database
  tables, not in config.
- The SaaS backend can push threat/whitelist updates to your site over an
  authenticated endpoint (it must prove knowledge of both your license key and the
  db-protection hash), and can also read statistics.
- Because protection depends on the daily sync, keep **cron running** on a regular
  schedule.
