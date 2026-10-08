<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BeeHotel Happening Today (beehotel_happening_today) — agent index

Generates a **daily operations report** (arrivals, departures, in-progress, rooms to clean,
leaving tomorrow) and **emails it on cron**. Dependencies: `bat`, `system`, `datetime`.
Core `^11`.

## Routes (`.routing.yml`)

- `beehotel_happening_today.admin_settings` —
  `/admin/beehotel/config/services/beehotel-happening-today` → `Form\SettingsForm`,
  perm `configure beehotel settings`.
- `beehotel_happening_today.daily_report` — `/admin/beehotel/happening-today` →
  `Controller\DailyReportController::dailyReport`, perm `configure beehotel settings`.

## Services (`.services.yml`)

`daily_report_generator` (`DailyReportGenerator`) ← `data_processor` (`DataProcessor`) ←
`unit_processor` (`UnitProcessor`) ← `order_service` (`OrderService`); `report_builder`
(`ReportBuilder`). Emailing uses `HappeningTodayMailService` + `hook_mail`.

## Config `beehotel_happening_today.settings` (schema present)

Keys: `enabled` (bool), `send_time` (string, e.g. `07:00`), `recipients` (sequence of emails),
`email_subject`; the form also handles `email_format`, `test_email`, `test_email_format`,
`save_test_email`. `hook_cron` sends once per day after `send_time`
(`beehotel_happening_today_should_send_report`), tracked in state
`beehotel_happening_today.last_report_sent`.

## Solution docs

- The report sections, cron send logic and settings →
  [config/report.md](config/report.md)
