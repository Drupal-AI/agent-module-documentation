<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit Trail (audit_trail) — agent index

Tamper-evident (HMAC-chained) audit-logging primitive for Drupal 11.3+/12. Installed line: 1.0.0-alpha (version-dir 1.0.x). License GPL-2.0-or-later. Package `Logging`.

## What it is
Selected log entries are written to the `audit_trail` table as a hash chain: each row carries a public `hash` = SHA-256(canonical payload ‖ previous row's hash) and an operator `hmac` = HMAC-SHA-256(hash, secret). Tampering breaks the chain downstream; `AuditTrailVerifier` reports every broken range in one walk. Two write paths: the PSR-3 logger (`audit_trail.logger`, `logger`-tagged) for `\Drupal::logger($channel)->x($msg, ['chain' => TRUE])`, and the structured `AuditTrail::event()` API. Rows split context into a permanent (PII-free, signed raw) and a transient (hash-signed, GDPR-purgeable) tier.

## Dependencies
- Runtime: `drupal:file`, `key:key` (`drupal/key ^1.18`). PHP >= 8.2. Core `^11.3 || ^12`.
- Dev-only: `drupal/paragraphs` (for the paragraphs submodule tests), `drush/drush`.

## Provides
- Services: `audit_trail` (event API), `audit_trail.logger` (PSR-3 chained logger), `audit_trail.chain_writer`, `audit_trail.verifier`, `audit_trail.secret_repository` (Key-backed), `audit_trail.chain_repository`, `audit_trail.chain_registry`, `audit_trail.forensic_stamp`, `audit_trail.chain_archiver` / `.segment_reader` / `.segment_restorer` / `.archive_location` / `.archive_envelope` / `.directory_checker`.
- Config entities: `audit_trail_chain` (channel→chain mapping, mode, contributors, filters, retention overrides), `audit_trail_secret` (Key-backed HMAC secret with pending/active/retired lifecycle).
- Plugin types: `#[ContextContributor]` (enrich rows) and `#[AuditTrailFilter]` (drop events); bundled filters `request_method`, `severity`.
- Tables: `audit_trail`, `audit_trail_outbox`, `audit_trail_checkpoint`, `audit_trail_acknowledgment`, `audit_trail_segment` (see `hook_schema` in `audit_trail.install`).
- Permissions: `view audit trail reports`, `run audit trail verification`, `administer audit trail` (all `restrict access: true`).
- 11 Drush commands (`audit_trail:*`) and a settings form at `audit_trail.settings_form`.

## Key routes
- `audit_trail.entries` `/admin/reports/audit-trail/entries` — listing (`view audit trail reports`).
- `audit_trail.entry_detail` `/admin/reports/audit-trail/entries/{id}` — detail + on-demand re-verify.
- `audit_trail.chain_verify` / `chains_verify_all[_full]` — verify (perm + `_csrf_token: TRUE`).
- `audit_trail.settings_form` `/admin/config/system/audit-trail` — retention, archive dir, auto-verify (`administer audit trail`).
- Secret / segment / acknowledgment CRUD under `/admin/config/system/audit-trail/*`.

## Submodules (documented under ./modules/<name>/1.0.x/)
- `audit_trail_entity` — entity create/update/delete bridge, per-bundle opt-in + field selection.
- `audit_trail_entity_paragraphs` — paragraph-ancestry context contributor.
- `audit_trail_file` — managed-file lifecycle bridge (incl. private-stream downloads).
- `audit_trail_tsa` — RFC-3161 TSA timestamping (providers, cron, verify).
- `audit_trail_user_auth` — authentication-event bridge (login/logout/reset/block/roles/...).

## Solution docs
- [agent/api/event-api.md](api/event-api.md) — the two write paths, `AuditTrail::event()`, `AuditTrailSubject`, PSR-3 `chain:`/`mode`, dispatch matrix, correlation id.
- [agent/architecture/chain.md](architecture/chain.md) — hash/HMAC construction, DB schema, verifier, checkpoints, retention lifecycle, secrets.
- [agent/config/settings.md](config/settings.md) — `audit_trail.settings`, `audit_trail_chain` and `audit_trail_secret` config, config schema.
- [agent/plugins/contributors-and-filters.md](plugins/contributors-and-filters.md) — writing context contributors and filters.
- [agent/operations/drush-and-routes.md](operations/drush-and-routes.md) — Drush commands, routes, permissions, cron.
