<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Trace Mail Log (trace_mail_log) — agent index

**Email audit logging: send/sent/failed events, transport transcripts, filtering and CSV/JSON export.**

- **Version:** 1.1.x (release 1.1.2)
- **Core:** ^10.3 || ^11 · package Mail
- **Configure:** `trace_mail_log.settings` (`/admin/config/system/mail-log/settings`, perm `administer mail_log`).
- **Routes (all permission-gated):** dashboard/list/detail/download/export/export-all -> `view mail_log`; settings/delete/delete-all -> `administer mail_log`. Both permissions `restrict access: TRUE`.
- **Mechanism:** Symfony Mailer event subscriber (`MessageEvent`/`SentMessageEvent`/`FailedMessageEvent`) + mail-manager/mailer decorators; correlates via `X-Trace-Mail-Log-UUID` header.
- **Storage:** `trace_mail_log` table (subject<=255, response<=512, recipients JSON) + transcript files at `private://mail-logs/Y/m/d/{uuid}-{event}.log`. `retention_days` (30) + `PurgeService`.
- **Settings:** `enabled` (true), `log_body` (false), `log_attachments` (false), `log_directory` (`private://mail-logs`), `items_per_page` (50).
- **Security/privacy:** No anonymous or `_access:TRUE` routes; all gated + restrict-access perms. Headers + transcript always written to file when present; **bodies only when `log_body` on (default off)**. Files default to private://. Queries use `escapeLike()`, no SQL concat. Data-at-rest: subjects/recipients (and optional bodies/headers) of all mail are retained — keep private:// private and tune retention.

See [configure/logging.md](configure/logging.md).
