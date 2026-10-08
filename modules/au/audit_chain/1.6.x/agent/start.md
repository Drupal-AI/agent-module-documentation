<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit Chain (audit_chain) — agent index

A **tamper-evident, hash-chained audit log** any Drupal module can write to. Package `Security`.
Depends on core **`user`** plus contrib **`key`** (`^1.20`) and **`encrypt`** (`^3.2`). Core
requirement `^10.6 || ^11.3`, PHP `>=8.1`. License GPL-2.0-or-later. Version **1.6.x**.

- **Writing to the chain — service API, channels, collector, verify/seal/reencrypt/prune** →
  [api/logging.md](api/logging.md)
- **Configuration — the `audit_chain.settings` object, schema, and the settings form** →
  [config/settings.md](config/settings.md)
- **Operating it — Drush commands, cron, scheduled verification, evidence export, status report** →
  [operations/verify-and-export.md](operations/verify-and-export.md)

## What it actually is

- **No entities, no plugin types, no permissions of its own.** One admin route,
  `audit_chain.settings` at `/admin/config/system/audit-chain`, gated by core
  **`administer site configuration`** (`AuditChainSettingsForm`). Everything else is a service API
  and Drush commands.
- **One append-only table** `audit_chain_log` (`hook_schema()` in `audit_chain.install`). Columns:
  `id, channel, timestamp, uid, operation, entity_type, bundle, entity_id, entity_label,
  ip_address, user_agent, metadata, prev_hash, row_hash, key_id, encryption_profile`. The chain is
  **global** (all channels interleaved in one `id` sequence) — a per-channel chain could not tell a
  deletion from a gap.
- **The chain:** `row_hash` = `HMAC-SHA256(prev_hash | canonical, key)` when a Key entity is
  configured, else `SHA-256(prev_hash | canonical)`. The canonical payload has a fixed key order and
  includes the forensic columns (label, IP, UA) so editing any of them breaks the chain. See
  `AuditChainLogger::hashRow()` / `buildCanonical()`.

## Services (`audit_chain.services.yml`)

- **`audit_chain.logger`** → `AuditChainLogger` (alias `AuditChainLoggerInterface`). The write +
  verify + seal + reencrypt + prune surface.
- **`audit_chain.collector`** → `AuditChainCollector`. Request-scoped dedupe buffer; flush at
  `kernel.terminate`.
- **`audit_chain.flush_subscriber`** → `AuditChainFlushSubscriber` (event_subscriber, drains the
  collector on `KernelEvents::TERMINATE`).
- **`audit_chain.scheduled_verifier`** → `ScheduledVerifier`. Cron-driven verification, records health
  in state, dispatches the failure event.
- **`audit_chain.evidence_exporter`** → `EvidenceExporter`. Off-system NDJSON export.
- **`logger.channel.audit_chain`** — the `audit_chain` log channel (SIEM streaming).

## Drush (`AuditChainCommands`, provides_drush_commands: true)

`audit-chain:verify` (`acv`), `audit-chain:seal` (`acs`), `audit-chain:reencrypt` (`acre`),
`audit-chain:export` (`ace`). Verify's **exit code is the contract** (non-zero = does not verify).

## Cron & events (`audit_chain.module`)

`hook_cron()` runs `ScheduledVerifier::runIfDue()` then the gated evidence export. Failure dispatches
`AuditChainVerificationFailedEvent` (`event: audit_chain.verification_failed`).
`hook_requirements()` (in `.install`) reports signing-key, encryption-profile, seal, and
scheduled-verification health on the status report.
