<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# YASM settings, report builder & scheduled email

## Settings form — `Form\YasmSettingsForm` (`ConfigFormBase`)

Route `/admin/reports/yasm/settings` (`yasm settings` permission). Editable config:
**`yasm.settings`** with three keys, all written by `saveConfig()`:

- `mail_monthly_enabled` (bool) — send the monthly report on cron.
- `mail_yearly_enabled` (bool) — send the yearly report on cron.
- `mail_recipients` (array of email strings) — textarea, one address per line; split, trimmed,
  filtered, and validated with `email.validator` in `validateForm()`/`validateTest()`.

Two extra submit buttons — **Send test monthly report** / **Send test yearly report**
(`submitSendMonthlyTest` / `submitSendYearlyTest`) — save config first, then immediately build the
previous month/year report and mail it to each recipient via a freshly created `yasm_html_mail`
plugin instance. As a `ConfigFormBase` submit, these are standard POST form submissions carrying
Drupal's CSRF form token. No config schema file ships, so the object is created on first save.

## Report builder — `Services\YasmReportMailer` (`yasm.report_mailer`)

- `buildMonthlyReportBody(int $year, int $month)` / `buildYearlyReportBody(int $year)` return
  `['subject','body']`. They call `collectReportRows()`, which iterates
  `YasmEntityDefinitions::ENTITIES_WITH_CREATED`, skips entities whose module is disabled, and for
  each entity + each bundle computes a cumulative total up to the period end and a diff versus the
  previous period end (via `countUpTo()` → `EntitiesStatistics::count()` with a `created <= end_ts`
  condition; `taxonomy_term` has no created field so its diff is null). Bundle labels pass through
  `strip_tags()`.
- `buildHtmlBody()` renders the `yasm_report_mail` Twig template with `renderer->renderInIsolation()`
  (required for D10.3+ mail rendering; keeps report cache metadata out of the current page).
- `sendMonthlyReport()` / `sendYearlyReport()` are the cron entry points: they no-op unless the
  matching `*_enabled` flag and a recipient list are set, and use the `state` keys
  `yasm.monthly_report_last_sent` (`Y-m`) / `yasm.yearly_report_last_sent` (`Y`) to fire at most once
  per period.

The controllers `YearlyReport::page` / `MonthlyReport::page` render the same data as an on-screen
DataTable with a `ReportGroupFilterForm` group filter (below).

## Mail pipeline

- **`Hook\YasmHooks::cron()`** calls `sendMonthlyReport()` + `sendYearlyReport()`.
- **`hook_mail` (`YasmHooks::mail`)** defines the `monthly_report` / `yearly_report` messages, sets
  From/Reply-To/Sender to `system.site` mail and HTML content headers.
- **`yasm_html_mail` plugin** (`Plugin\Mail\YasmHtmlMail`) formats the body as a
  `multipart/alternative` payload (quoted-printable plain-text + HTML parts, random MIME boundary via
  `random_bytes`), MIME-encodes the subject, and delegates delivery to core `php_mail`.
- **`Mail\YasmMailConfigOverride`** (config.factory.override, priority -30) overrides `system.mail`
  so `interface.yasm = yasm_html_mail`, i.e. every `yasm` email uses the HTML plugin.
- **`hook_mail_alter` (`YasmHooks::mailAlter`)** is a defensive fallback: for `yasm`
  `monthly_report`/`yearly_report` messages still queued as plain text it re-formats and sends via
  `yasm_html_mail`, then sets `send = FALSE` so core does not double-send.

## Group filter form — `Form\ReportGroupFilterForm`

A **GET** filter form (`#method = 'get'`) shown on the reports and timeline pages when Group is
enabled. It lists only the groups the current user belongs to (`GroupVersionManager::getUserGroups`
→ `buildGroupOptionsWithParents`), and the controllers intersect any submitted `gid` against that
same option set, so a user cannot filter by a group they are not in. Because it only narrows a
read-only report (no state change), it deliberately disables the CSRF token (`#token = FALSE`) and
strips Drupal's internal hidden fields so the resulting URL carries only `date_filter`/`gid`.
