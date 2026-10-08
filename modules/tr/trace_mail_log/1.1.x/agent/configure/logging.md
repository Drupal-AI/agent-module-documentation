<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Trace Mail Log — configuration & routes

## Settings (config `trace_mail_log.settings`, form at `/admin/config/system/mail-log/settings`)
| Key | Default | Effect |
|-----|---------|--------|
| `enabled` | true | Master on/off for all logging |
| `retention_days` | 30 | Age after which `PurgeService` deletes rows |
| `log_directory` | `private://mail-logs` | Where transcript files are written |
| `log_body` | false | Write HTML/text body into transcript files |
| `log_attachments` | false | Include attachments |
| `items_per_page` | 50 | Dashboard page size |
| `date_format_list` / `date_format_detail` | short / medium | UI date formats |

## Permissions (restrict access: TRUE)
- `view mail_log` — dashboard, list, detail, download, export, export-all.
- `administer mail_log` — settings, delete entry, delete all.

## Routes
`/admin/config/system/mail-log` (dashboard), `/list`, `/{id}` (detail), `/{id}/download`, `/export/{csv|json}`, `/export-all/{csv|json}`, `/settings`, `/{id}/delete`, `/delete-all`.

## What is recorded
DB row per event: uuid, message_id, event_type (queued/sending/sent/failed/requeued), status, mail_key, sender, recipients (JSON to/cc/bcc), subject (<=255), transport_type, response_code, response_message (<=512), transcript_file, created.
Transcript file (only when transcript/headers/body present): UUID, recipients, **HEADERS (always when present)**, **BODY (only if `log_body`)**, transport transcript, server response, errors.

## Data-at-rest guidance
Keep `private://` outside the webroot and protected; leave `log_body`/`log_attachments` off unless debugging; set `retention_days` to the minimum you need. Export controllers only emit DB columns (never bodies) and are gated by `view mail_log`.
