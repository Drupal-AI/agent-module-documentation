<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, routes & admin UI

## Install / enable

`drush en ddos_security` (or via the UI). Only dependency is core `user`. On install,
`ddos_security_schema()` creates the `ddos_security` table and `config/install/ddos_security.settings.yml`
seeds defaults. Uninstall (`hook_uninstall`) deletes the `ddos_security.settings` config. There are **no
custom permissions** — every admin route is gated by core `administer site configuration`.

## Config object: `ddos_security.settings`

Edited at **`/admin/config/ddos-security-config/settings`** (form
`Form\DdosSecurityConfigSettingsForm`, route `ddos_security.settings`, config-translation enabled). Keys
(seeded from `config/install/ddos_security.settings.yml`):

| Key | Type / default | Meaning |
|---|---|---|
| `enable_ddos` | bool, `1` | Master on/off for the request throttle. |
| `redirect_url` | string, `/ddos-alert-message` | Internal page blocked visitors are redirected to. **Disabled** in the form (fixed). |
| `message` | text_format (full_html) | Shown on the alert page to a `blocked` IP. |
| `403_message` | text_format (full_html) | Shown on the alert page to a not-yet-blocked anonymous visitor (pre-attack 403 text). |
| `whitelisted_ip_addresses` | string (one IP per line) | IPs never rate-logged; validated with `FILTER_VALIDATE_IP`. |
| `whitelisted_pages` | string (one `/path` per line) | Paths whose hits are not logged; each must start with `/`. |
| `total_hits` | string, `15` | Allowed hits **per minute** per IP before blocking. |
| `enable_mail_log` | bool, `0` | Send the daily cron report mail. |
| `log_mail_id` | email | Recipient of the report mail; falls back to `system.site` mail. |
| `enable_malicious_requests` | bool, `1` | Turn on user-agent + URL substring filtering. |
| `malicious_requests_list` | string, comma-separated | Substrings that, if present in the request URL, deny access (default includes `<script`, `<?php`, `alert(`, URL-encoded variants). |

**Config schema** (`config/schema/ddos_security.schema.yml`) only declares `message` and `403_message`
(both `text_format`); the remaining keys have no schema entry (they are read via `->get()` with defaults).

`validateForm()` enforces: `redirect_url` begins with `/`; every whitelisted IP passes
`FILTER_VALIDATE_IP`; every whitelisted page begins with `/`; `log_mail_id` (if set) is a valid email.

## Routes & menu

Defined in `ddos_security.routing.yml` (admin routes carry `_admin_route: TRUE`):

- `ddos_security.admin_config` — `/admin/config/ddos-security` — core `SystemController::systemAdminMenuBlockPage`
  landing (menu block), `administer site configuration`.
- `ddos_security.settings` — settings form (above).
- `ddos_security.ddos_security_entry_search` — `/admin/config/ddos-security-entry/{search_keyword}` —
  `Controller\DdosSecurityEntryList::entryList`; the paged IP table with an embedded search form.
- `ddos_security.ddos_security_entry_delete` — `/admin/config/ddos-security-action/{action}/{ip}` —
  `Form\DdosSecurityEntryDeleteForm` (`ConfirmFormBase`); `{action}` ∈ block/unblock/delete, `{ip}` are
  the crypt-obfuscated values produced by the entry list's action links.
- `ddos_security.csv_export` — `/admin/config/ddos-security/export/csv` —
  `Controller\DdosSecurityCSVReport::build`; streams a `ddos-report-<date>.csv` (`text/csv` attachment).
- `ddos_security.displaypage` — `/ddos-alert-message` — `Controller\DdosSecurityPage::displayAlertMessage`;
  requirement `access content` (this is the public blocked/alert page). Renders the `ddos_alert_message`
  theme hook with the configured `message` (for `blocked` IPs) or `403_message` (otherwise).

Menu links (`ddos_security.links.menu.yml`) place Configurations → Settings / Entry List / CSV Export
under `system.admin_config`. `ddos_security.links.task.yml` adds a local task on the settings route.

## Admin entry list & actions

`DdosSecurityEntryList::entryList()` renders a 20-per-page table grouped by `ip_address` + `status`
showing S.no, Security Number (`MAX(sno)`), last access, IP, hit count (`COUNT(sid)`), status, and
Update/Delete action links. Each IP row's action links carry crypt-obfuscated `action`/`ip` segments
(via `ddos_security.crypt`) into the delete/confirm route. The embedded `DdosSecurityEntrySearch` form
validates the keyword (min 3 chars, `[A-Za-z0-9.]` only) before searching by IP/status. The page sets
`#cache max-age = 0`.

`DdosSecurityEntryDeleteForm` (a confirm form) decrypts the `action`/`ip` route segments, validates the
decrypted IP with `FILTER_VALIDATE_IP`, and on confirm runs `block`→`status='blocked'`,
`unblock`→`status='allowed'`, or `delete`→row delete, all keyed on `ip_address`, then redirects back to
the entry list.

## CSV export & cron mail

`DdosSecurityCSVReport::build()` selects IP/status grouped rows (`MAX(sno)`, `COUNT(sid)`), writes them
to a `php://temp` handle with `fputcsv`, and returns a `Response` with `Content-Disposition: attachment`.
`hook_cron` (in `.module`), once per 24h (state key `ddos_security.next_execution`), if `enable_mail_log`
is on, sends a `ddos_security` mail (`hook_mail`) to `log_mail_id` (or site mail) containing a link to the
CSV export route.
