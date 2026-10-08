<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Update Notify — configuration

Form: `/admin/modules/update/notify` (permission `view update notifications`). Config object: `update_notify.settings`.

## Keys
| Key | Meaning |
|---|---|
| `enabled` | Master switch; when on, cron checks & sends |
| `frequency` | `daily` / `weekly` / `monthly` (drives next-send calc) |
| `include_key` | Append an icon legend to the message |
| `include_php` | Add current PHP version row |
| `include_host` | Add site host to the message |
| `custom_host` | Override the detected host label |
| `email` | Enable email delivery |
| `email_to` | Recipient (defaults to `system.site` mail) |
| `slack` | Enable Slack delivery (requires configured `slack` module) |
| `slack_channel` | Target Slack channel (defaults to Slack module's) |

## Scheduling
`NotifyService::calculateNextSend()`:
- weekly → next Thursday 09:00
- monthly → last Thursday of this/next month
- default (daily) → tomorrow 09:00

State keys `update_notify.last_sent` / `update_notify.next_send` prevent duplicate sends. `readyToSend()` compares now to next-send unless `$ignore_last_sent` is passed.

## Immediate send
When `enabled` is on, the form shows a **Notify now** button (`notifyNow()`) that saves config then calls `triggerNotifications(TRUE)`, ignoring the schedule.

## Message content
`createMessage()` renders a `TextTable` of Name / Current / Recommend / URL / notice, with `🔒` security, `⛔` unsupported, `⬆️` major flags. Slack variant uses markdown wrapping.
