<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit Trail File activity (audit_trail_file) — agent index

Submodule of [audit_trail](../../../../agent/start.md). Core `^11.3 || ^12`. Depends on `audit_trail`, core `file`.

## What it does
`AuditTrailFileHooks` (`src/Hook/AuditTrailFileHooks.php`) implements `#[Hook('file_insert'|'file_update'|'file_delete'|'file_download')]` and records each as `AuditTrail::event('audit_trail_file', $verb, new AuditTrailSubject('file:<fid>', $file), [uri, filename, mime, size, status])`. Verbs:
- `file_created` (insert), `file_updated` (update), `file_made_permanent` (update where status flips temporary→permanent), `file_deleted` (delete, captured before bytes are unlinked).
- `file_downloaded` (`hook_file_download`) — **private:// stream only**; public files bypass Drupal. Gated before the `loadByUri()` lookup by the per-event config; returns NULL so it never competes with the module actually granting/denying access.

## Provides
- Chain: `audit_trail.chain.audit_trail_file` (claims channel `audit_trail_file`). Ships a `request_method` filter (mode allow, methods GET/HEAD, scoped to action `file_downloaded`) so WebDAV/other non-byte-serving verbs that piggyback on `hook_file_download` don't emit download rows.
- Config: `audit_trail_file.settings:events` — per-verb booleans (all true by default; missing key defaults true).
- Route/form: `audit_trail_file.settings_form` `/admin/config/system/audit-trail/file` (`AuditTrailFileSettingsForm`, permission `administer audit trail`).
- Config schema: `audit_trail_file.settings`.

No own permissions (uses the parent's `administer audit trail`). The base module supplies chain/HMAC/verifier.
