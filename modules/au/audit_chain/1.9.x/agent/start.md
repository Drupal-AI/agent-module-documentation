<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit Chain (audit_chain) — agent index

A **tamper-evident, hash-chained audit log** any Drupal module can write to. Package `Security`.
Depends on core **`user`** plus contrib **`key`** (`^1.20`) and **`encrypt`** (`^3.2`). Core
requirement `^10.6 || ^11.3`, PHP `>=8.1`. License GPL-2.0-or-later. Version **1.9.x**.
Ships one optional submodule, **`audit_chain_mcp`** (see below).

- **Writing to the chain — service API, channels, collector, verify/seal/reencrypt/prune** →
  [api/logging.md](api/logging.md)
- **Configuration — the `audit_chain.settings` object, schema, and the settings form** →
  [config/settings.md](config/settings.md)
- **Operating it — Drush commands, cron, scheduled verification, evidence export, status report** →
  [operations/verify-and-export.md](operations/verify-and-export.md)
- **Recovery segments — the `audit-chain:recovery-*` successor protocol** →
  [operations/recovery.md](operations/recovery.md)
- **Reports dashboard — `/admin/reports/audit-chain`, the permission, metrics, chart** →
  [reports/dashboard.md](reports/dashboard.md)
- **Submodule `audit_chain_mcp`** — governed MCP tools →
  [../../modules/audit_chain_mcp/1.9.x/agent/start.md](../../modules/audit_chain_mcp/1.9.x/agent/start.md)

## What it actually is

- **No config entities, no plugin types.** One admin route `audit_chain.settings` at
  `/admin/config/system/audit-chain`, gated by core **`administer site configuration`**
  (`AuditChainSettingsForm`), and one reports route `audit_chain.dashboard` at
  `/admin/reports/audit-chain`, gated by the module's own **`view audit chain reports`** permission
  (`AuditChainDashboardController`). Everything else is a service API and Drush commands.
- **Three tables** (`hook_schema()` in `audit_chain.install`): `audit_chain_log` (the append-only
  chain), `audit_chain_mutex` (a singleton row lock serialising appends), and `audit_chain_recovery`
  (append-only signed recovery manifests). `audit_chain_log` columns: `id, channel, timestamp, uid,
  operation, entity_type, bundle, entity_id, entity_label, ip_address, user_agent, metadata,
  prev_hash, row_hash, key_id, encryption_profile`. The chain is **global** (all channels
  interleaved in one `id` sequence) — a per-channel chain could not tell a deletion from a gap.
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
- **`audit_chain.recovery`** → `RecoverySegments`. Explicit, signed successor-segment protocol.
- **`audit_chain.metrics`** → `AuditChainMetrics`. Windowed keyed/unkeyed counts + integrity read
  for the dashboard (never reads metadata/IP/UA/label).
- **`audit_chain.chart_renderer`** → `AuditChainChartRenderer`. Donut chart with an inline-SVG
  fallback; upgrades to `drupal/charts` when a library plugin is present.
- **`logger.channel.audit_chain`** — the `audit_chain` log channel (SIEM streaming).

## Drush (`provides_drush_commands: true`)

`AuditChainCommands`: `audit-chain:verify` (`acv`), `audit-chain:seal` (`acs`),
`audit-chain:reencrypt` (`acre`), `audit-chain:export` (`ace`). `RecoveryCommands`:
`audit-chain:recovery-prepare` / `-activate` / `-verify` / `-export`. Verify's **exit code is the
contract** (non-zero = does not verify).

## Cron & events (`audit_chain.module`)

`hook_cron()` runs `ScheduledVerifier::runIfDue()` then the gated evidence export. Failure dispatches
`AuditChainVerificationFailedEvent` (`event: audit_chain.verification_failed`).
`hook_requirements()` (in `.install`) reports signing-key, encryption-profile, seal,
scheduled-verification and retention health on the status report.
