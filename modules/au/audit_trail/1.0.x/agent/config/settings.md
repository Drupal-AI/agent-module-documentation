<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration: settings, chains, secrets

Schema in `config/schema/audit_trail.schema.yml`; install defaults in `config/install/`.

## `audit_trail.settings` (config_object) — form at `/admin/config/system/audit-trail`
Requires `administer audit trail`. Keys (install defaults shown):
- `cron_archive`: `enabled` (false), `cron_interval_seconds` (3600, min 60), `archive_after` (`P7D`), `live_purge_after` (`P3M`), `file_purge_after` (`P2Y`), `transient_purge_after` (null=disabled), `compact_after` (null=disabled), `segment_granularity` (`week`; one of hour|day|week|month). ISO-8601 durations, clocked from a row's `created`; each stage must be older than the previous.
- `archive_directory` (`private://audit_trail`) — stream wrapper or absolute path; `public://` is refused (rows may carry PII).
- `in_transaction_write_mode` (`outbox`) — `outbox` | `memory` | `inline` (see architecture doc).
- `keep_rolled_back_writes` (false) — memory-mode only.
- `auto_verify_enabled` (true), `auto_verify_full_walk_every_days` (7), `auto_verify_max_age_hours` (24, warns on status report).
- `checkpoint_min_rows` (100, min 1), `checkpoint_retain` (50, min 1).

## `audit_trail_chain.*` (config entity) — maps channels to a chain
Default install ships `audit_trail.chain.default`. Fields:
- `id` (matches the `chain` column), `label`, `status` (accepts new writes).
- `mode`: `flag` (default — only `chain: TRUE` entries chain) or `auto` (every entry on a claimed channel chains).
- `channels[]`: PSR-3 channels routed into this chain (empty = the chain id is itself the channel).
- Retention overrides (nullable, inherit global): `archive_after`, `live_purge_after`, `file_purge_after`, `compact_after`, `transient_purge_after`, `segment_granularity`.
- `contributors[]`: ordered `{plugin_id, weight, settings}` — the context contributors that build each row's buckets.
- `filters[]`: ordered `{plugin_id, weight, settings}` — first FALSE vote drops the event.
- `chain_only` (bool): when TRUE, entries go to `audit_trail.logger` only (dblog/syslog never see them).

Edited on the chains collection/edit UI (entity `audit_trail_chain`). Submodules ship their own chains (`audit_trail_entity`, `audit_trail_file`, `audit_trail_user_auth`).

## `audit_trail_secret.*` (config entity) — HMAC signing secrets
Fields: `id` (auto `secret_<n>`), `label`, `secret_id` (int, matches the `secret_id` row column), `key_id` (referenced `drupal/key` Key entity id — where the bytes live), `secret_status` (`pending`|`active`|`retired`), `created`, `retired`. Managed at `/admin/config/system/audit-trail/secrets` with custom `activate` / `retire` forms; rotation via `drush audit_trail:rotate-secret`. Nothing is chained until a chain has an active secret; provision a Key entity (≥32 bytes) first, then create + activate the secret.

## Bundled filter settings schema
- `audit_trail.filter.request_method`: `mode` (allow|disallow), `methods[]`, `channels[]`, `actions[]`, `reject_silently`.
- `audit_trail.filter.severity`: `min_severity` (0–7), `channels[]`, `actions[]`, `reject_silently`.
Context-contributor / filter instance settings default to the empty mappings `audit_trail.context_contributor.*` / `audit_trail.filter.*`; a plugin with settings declares `audit_trail.context_contributor.<id>` / `audit_trail.filter.<id>` in its own module.
