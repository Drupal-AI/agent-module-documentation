<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit Chain — programmatic API

## Writing to the chain (two constraints)

1. **Do not log per access check.** A hook like `hook_entity_field_access()` fires per field, per entity, per render;
   a direct `log()` there turns one action into dozens of unremovable rows. Use the **collector** instead.
2. **Rotating the encryption profile orphans prior rows** until they are re-encrypted (`drush audit-chain:reencrypt`).

Consumers are identified by a **channel** (a short machine name, e.g. `mcp_sentinel`, `personnel`), bound into the
row hash so an entry can't be re-attributed to another channel undetected.

### Preferred: `audit_chain.collector` (service `AuditChainCollector`)

Buffers per request, deduplicates, and the `AuditChainFlushSubscriber` flushes once at `kernel.terminate` (writing
after the response keeps the chain's global append lock off the request's critical path).

```php
\Drupal::service('audit_chain.collector')->collect(
  channel: 'personnel',
  operation: 'field_read',
  metadata: ['entity_type' => 'node', 'bundle' => 'record', 'id' => 42, 'label' => 'Jane'],
  // dedupeKey defaults to channel:operation:entity_type:id — first occurrence wins, metadata NOT merged.
);
```
Also: `flush(): int` (safe to call twice — clears buffer first), `count(): int` (pending after dedup).

### Direct: `audit_chain.logger` (service, implements `AuditChainLoggerInterface`)

Type-hint `AuditChainLoggerInterface` (or `Drupal\audit_chain\AuditChainCollector`) for autowiring. Methods:

- `log(string $channel, string $operation, array $metadata = []): void` — append one entry. Metadata keys `entity_type`, `bundle`, `id`, `label` are promoted to indexed columns; the rest is serialized into `metadata` (encrypted when a profile is configured). All of it is covered by the hash. `operation` is truncated to 64 bytes.
- `verify(): array` — walk the whole chain (global, no channel arg). Returns `ok`, `broken_at`, `reason`, `unkeyed_rows`, `unkeyed_through`, `verified_from`, `sealed_through`, `seal_intact`. `reason` distinguishes `tampered` (edited/reordered) from `written_unkeyed` (intact but unsigned) and `seal_broken`. Additive shape — read the keys you need.
- `sealPrefix(int $throughId, string $reason): array` → `{sealed, message, seal}`. Only covers rows that don't verify under current keys; writes an audit entry.
- `getSeal(): ?array` — the active seal record (or NULL).
- `decodeMetadata(string $stored, string $encryptionProfile = ''): array` — decode/decrypt a stored metadata value; tries the row's own profile first, then the configured one, then plaintext.
- `reencrypt(string $fromProfile, string $toProfile, int $limit = 0): array` → `{updated, failed, remaining, refused}`. Only rewrites `metadata` + `encryption_profile`; never hashed columns.
- `prune(string $channel, int $retentionDays): int` — delete a channel's old rows. Breaks the chain at the boundary (inherent to append-only); export first if history must stay provable.

## Other services

- `audit_chain.scheduled_verifier` (`ScheduledVerifier`) — driven by `hook_cron`. `runIfDue(): ?array` runs when `verify_interval` has elapsed; `runNow(): array` runs immediately and records the verdict in state key `audit_chain.scheduled_verification`. Under `verify_require_keyed` it fails (`keyed_verification_unavailable`) rather than accepting an unkeyed pass.
- `audit_chain.evidence_exporter` (`EvidenceExporter`) — `exportTo(string $destination, ?int $fromId = null, ?string $channel = null, ?int $limit = null): array` returns `{ok, delivered, last_id, remaining, reason}`. See the drush doc for delivery semantics. `EvidenceExporter::redactDestination($url)` strips credentials for logging.

## Alert contract: react to a failed scheduled verification

Subscribe to event `AuditChainVerificationFailedEvent::EVENT_NAME` (`'audit_chain.verification_failed'`), dispatched
**only on failure**, to wire your own alerting (webhook/email/dashboard) without Audit Chain owning those channels.
The event carries `public readonly array $run` (`time`, `ok` = FALSE, `reason`, and, when verification executed, the
full `verify()` verdict under `verdict`). The chain is never rewritten by the check; a healthy run updates state
silently. A failure is also logged to the `audit_chain` logger channel.
