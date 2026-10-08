<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — the `abuseipdb.settings` config object & admin forms

## Install & enable

```bash
composer require drupal/abuseipdb
drush en abuseipdb -y
# then enable a ban backend if you want bans to happen:
drush en abuseipdb_core_ban -y   # or abuseipdb_advban -y
```

No runtime composer requirements. Get an API key at https://www.abuseipdb.com/register and enter
it on the Settings tab. Without a ban submodule the active ban manager is `- None -` (bans are no-ops).

## The config object

Everything is stored in the single config object **`abuseipdb.settings`** under an `abuseipdb`
mapping. Schema: `config/schema/abuseipdb.schema.yml`. Install defaults:
`config/install/abuseipdb.settings.yml`.

| Key (under `abuseipdb.`) | Type | Default | Meaning |
|---|---|---|---|
| `api_key` | text | `'admin'` | AbuseIPDB account API key. Sent as the `Key:` request header. |
| `abuse_confidence_score` | integer | `75` | Threshold 0–100. IP is "abusive" when its score ≥ this. **0 bans every IP.** |
| `ban_manager` | string | `abuseipdb.empty_ban_manager` | Service id of the active `AbuseipdbBanManagerInterface`. |
| `check_timeout` | string | `'0'` | Guzzle `timeout` (seconds) for **check** calls only. `0` = wait indefinitely. |
| `forms` | string | `''` | Substring-matched form IDs to add the IP validator to (see below). |
| `forms_ban_ip` | boolean | `true` | Also ban the IP when a checked form submission is abusive. |
| `paths_check` | string | `''` | Newline/`matchPath` list of paths checked on every request (REQUEST event). |
| `paths_check_ban_ip` | boolean | `true` | Ban an abusive checked-path IP; if false, redirect to safe path instead. |
| `paths_check_safe_path` | string | `'/'` | Redirect target when an abusive check-path IP is not banned. |
| `paths_report` | string | `''` | Path "blacklist"; hits are reported to AbuseIPDB (TERMINATE event). |
| `paths_report_ban_ip` | boolean | `true` | Also ban IPs that hit a blacklisted path. |
| `shutdown` | boolean | `false` | Emergency shutdown — short-circuits all checks/reports/bans. |
| `whitelist` | string | `''` | Newline list of IPs/CIDR ranges never checked or banned. |

## Routes & permission

All routes are under `/admin/config/services/abuseipdb` and require **`administer site
configuration`** (`abuseipdb.routing.yml`). Local tasks in `abuseipdb.links.task.yml`, menu links
in `abuseipdb.links.menu.yml`.

| Route | Path | Form class | Writes keys |
|---|---|---|---|
| `abuseipdb.settings` | `/` | `Form\Settings` | `api_key`, `shutdown`, `abuse_confidence_score`, `ban_manager`, `check_timeout` |
| `abuseipdb.form_check` | `/form-check` | `Form\FormCheck` | `forms`, `forms_ban_ip` |
| `abuseipdb.paths_check` | `/paths-check` | `Form\PathsCheck` | `paths_check`, `paths_check_ban_ip`, `paths_check_safe_path` |
| `abuseipdb.paths_report` | `/paths-report` | `Form\PathsReport` | `paths_report`, `paths_report_ban_ip` |
| `abuseipdb.report` | `/report` | `Form\Report` | *(none — calls Reporter directly)* |
| `abuseipdb.whitelist` | `/whitelist` | `Form\IpWhiteList` | `whitelist` |

The only module permission is **`abuseipdb bypass check`** (`abuseipdb.permissions.yml`): holders
are exempted from every check/report/ban via `Reporter::canUserBypass()`.

## The forms (all extend `ConfigFormBase` except `Report`)

- **`Settings`** — injects `abuseipdb.ban_manager_collector`. Builds the ban-manager `<select>` from
  `getBanManagers()` (id → module name); warns if none found. Renders the API key
  (`#type => 'textfield'`), Abuse Confidence Score (`number`, 0–100), Check API Timeout (`number`,
  step 0.001, max = PHP `max_execution_time` or 60), and Emergency shutdown (`checkbox`). No real
  `validateForm()`.
- **`FormCheck`** — textarea of comma/substring form IDs + `forms_ban_ip` checkbox.
- **`PathsCheck`** — `paths_check` textarea, `paths_check_safe_path` textfield, `paths_check_ban_ip`
  checkbox, and an AJAX **Test a path** field (`testPathCallback()` runs `PathMatcher::matchPath`).
  Form id `abuseipdb_paths_form` (shared with `PathsReport`).
- **`PathsReport`** — `paths_report` textarea (blacklist) + `paths_report_ban_ip` checkbox + the
  same AJAX path tester. Warns against listing valid Drupal paths.
- **`IpWhiteList`** — `whitelist` textarea; one IP or CIDR (`0.0.0.0/24`) per line.
- **`Report`** (`FormBase`) — manual report. Injects `messenger` + `abuseipdb.reporter`. Fields:
  `ip_address` (required, validated with `FILTER_VALIDATE_IP`), `comment` (max 1499),
  `categories` (required checkboxes from `abuseipdb_get_categories_mapping()`), `ban_ip` checkbox.
  `submitForm()` calls `Reporter::report()` then optionally `Reporter::ban()`; success requires no
  exception and HTTP 200.

## Update hooks (`abuseipdb.install`)

- `abuseipdb_update_8001` — seed `abuse_confidence_score = 75`.
- `abuseipdb_update_10301` — 3.x migration: convert old `anonymous_only` to per-role
  `abuseipdb bypass check` grants; rename `paths` → `paths_report` and `paths_ban_ip` →
  `paths_report_ban_ip`.
- `abuseipdb_update_11000` — add empty `whitelist` if missing.

## Security note (operational, not a vuln)

Reputation blocking has false positives on shared/CGNAT/VPN egress IPs — review auto-bans, keep a
whitelist, and give trusted roles `abuseipdb bypass check`. Reporting sends visitor IPs to a third
party (AbuseIPDB), a privacy consideration for user data.
