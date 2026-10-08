<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Trace Mail Log is an email audit trail for Drupal: it records every outbound message (sending, sent, failed, queued, requeued) with sender, recipients, subject, transport type, server response code and a correlation UUID, and offers a dashboard, per-entry detail, filtering and CSV/JSON export.
---
It subscribes to Symfony Mailer events (`MessageEvent`, `SentMessageEvent`, `FailedMessageEvent`) and also decorates the mail manager / mailer, tagging each message with an `X-Trace-Mail-Log-UUID` header so events for one email correlate. `MailLogService::log()` writes a row to the `trace_mail_log` table (subject truncated to 255, response message to 512, recipients JSON-encoded) and — when transcript/headers/body data is present — writes a full human-readable transcript file to `private://mail-logs/YYYY/MM/DD/{uuid}-{event}.log`. A retention setting plus `PurgeService` trims old records. There is optional Webform email-status tracking.

Operational/privacy notes for operators. By design this module stores message metadata; full **email headers and the transport transcript are always written to the transcript file** when available, while **message bodies are only written when `log_body` is enabled (default OFF)** and attachments only when `log_attachments` is on (default OFF). Transcript files default to the **private** filesystem (`private://mail-logs`), and every route is permission-gated: viewing/exporting requires `view mail_log` and settings/delete require `administer mail_log`, both declared `restrict access: TRUE`. Queries use the DB API with `escapeLike()` (no raw SQL concatenation). The main data-at-rest consideration is that subjects, recipients and (optionally) bodies/headers of all site email are retained; keep `private://` truly private, set a sane `retention_days`, and leave `log_body` off unless needed.
---
- Audit all outbound site email with a searchable dashboard.
- Correlate queued/sending/sent/failed events for one email via its UUID.
- View a single message's full detail and server response.
- Download the full transport transcript for a message.
- Filter the log by status, event type, recipient or subject.
- Export filtered log entries as CSV.
- Export filtered log entries as JSON.
- Export the entire log (`export-all/{format}`).
- Diagnose SMTP failures via parsed response codes/messages.
- Track delivery through SMTP, sendmail, native or null transports.
- Turn body logging on/off with the `log_body` setting (default off).
- Turn attachment logging on/off (`log_attachments`, default off).
- Set a retention period (`retention_days`, default 30) and auto-purge old rows.
- Change the transcript storage directory (`log_directory`, default `private://mail-logs`).
- Delete a single log entry.
- Delete all log entries at once.
- Restrict who can read mail logs via the `view mail_log` permission.
- Restrict settings/deletion via `administer mail_log`.
- Track Webform submission email status.
- Configure page size (`items_per_page`) and date formats for the UI.
- Verify a newsletter/transactional send actually reached the transport.
