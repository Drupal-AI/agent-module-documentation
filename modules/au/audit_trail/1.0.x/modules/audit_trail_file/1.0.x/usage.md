<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Chains managed-file lifecycle events — create, update, made-permanent, delete, and private-stream downloads — into the tamper-evident audit trail with dedicated action verbs.

---

`audit_trail_file` subscribes to `hook_file_insert` / `_update` / `_delete` / `_download` and records each managed-file event as a chained audit-trail row on channel `audit_trail_file` (resource `file:<fid>`), keeping file-specific verbs rather than folding them into generic entity rows: `file_created`, `file_updated`, `file_made_permanent` (the temporary→permanent status flip), `file_deleted`, and `file_downloaded`. Each row carries the file's uri, filename, mime, size and status in transient context. Downloads are audited only for the `private://` stream (public files are served by the web server and bypass Drupal); the shipped chain scopes `file_downloaded` to GET/HEAD with a request-method filter so non-byte-serving verbs (e.g. WebDAV PROPFIND) do not emit download rows. Every verb is per-event opt-in via `audit_trail_file.settings:events`. The base `audit_trail` module provides the tamper-evidence. Requires `audit_trail` and core `file`.

---

- Record who uploaded which managed file, and when, in a tamper-evident chain.
- Audit private-file downloads for a compliance or DLP trail.
- Flag the moment a temporary file is promoted to permanent as its own verb.
- Track file replacement / rename / move as `file_updated` with a diff.
- Record file deletions before the bytes are unlinked, capturing last-known state.
- Turn off high-volume `file_downloaded` auditing per site via the events config.
- Keep file events on their own filterable channel, separate from entity audit rows.
- Investigate exfiltration by querying `file_downloaded` rows for a private file.
- Correlate a file's lifecycle by filtering the entries list on `file:<fid>`.
- Audit programmatic file operations (saveData, Migrate, remote copy) the same as uploads.
- Configure enabled verbs at Configuration → System → Audit Trail → File events.
- Feed a defensible record of document handling for regulated workflows.
