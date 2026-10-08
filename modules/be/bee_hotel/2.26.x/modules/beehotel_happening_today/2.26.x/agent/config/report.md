<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Daily report: sections, cron, settings

## Report data

`hook_theme` defines `daily_report_main` (template `daily-report-main`) plus per-section themes
(`beehotel_arriving`, `beehotel_departures`, `beehotel_leaving_tomorrow`,
`beehotel_arrived_yesterday`). Sections: `arrivals`, `departures`, `progress`,
`first_night_passed`, `rooms_to_clean`, `are_leaving_tomorrow`, `special_notes`.
`DataProcessor::prepareData()` (via `UnitProcessor`/`OrderService`) fills them from BAT
events + Commerce orders for the current day.

## Cron send

`beehotel_happening_today_cron()`:
1. returns unless config `enabled`;
2. computes scheduled vs current time from `report_time`/`send_time`;
3. `beehotel_happening_today_should_send_report()` returns TRUE only after the scheduled time and
   when `last_sent_date !== today` (once per day);
4. builds data via the report generator and sends through
   `HappeningTodayMailService::sendHappeningTodaySummary()`;
5. stores `beehotel_happening_today.last_report_sent` in state.

`hook_mail` (`beehotel_happening_today_daily_report`) sets an HTML `text/html` message.

## Settings form (`Form\SettingsForm`)

At `/admin/beehotel/config/services/beehotel-happening-today` (perm `configure beehotel settings`).
Writes config `beehotel_happening_today.settings`: `enabled`, `send_time`, `recipients[]`,
`email_subject`, `email_format`, plus `test_email` / `test_email_format` / `save_test_email` for a
test send.
