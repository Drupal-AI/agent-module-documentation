<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Writing to and verifying the chain (`AuditChainLoggerInterface`)

Service `audit_chain.logger` (class `Drupal\audit_chain\AuditChainLogger`, alias
`Drupal\audit_chain\AuditChainLoggerInterface`). Inject the interface; do not new it up.

## Appending entries

```php
\Drupal::service('audit_chain.logger')->log('personnel', 'field_read', [
  'entity_type' => 'node',
  'id' => $node->id(),
  'field' => 'field_salary',
]);
```

- **`log(string $channel, string $operation, array $metadata = []): void`** — appends one row.
  `channel` (consumer machine name) and `operation` are each truncated to 64 bytes. Of `$metadata`,
  the keys **`entity_type`, `bundle`, `id`, `label`** are promoted to indexed columns
  (`entity_id` = string of `id`, `entity_label` truncated to 255); every other key is serialised into
  the `metadata` column. Actor (`uid`), `timestamp`, `ip_address`, `user_agent` are captured
  automatically. **All of it, including `channel`, is covered by the hash** — a row cannot be
  re-attributed after the fact.
- **`logKeyed(...)`** — same shape, but **throws `AuditChainSigningUnavailableException` and writes
  nothing** unless HMAC signing will actually apply (a resolvable non-empty key). Use from
  evidence-required consumers that must not accept an unsigned row. Ordinary auditing should use
  `log()`, which prefers writing an unsigned row over dropping the record.
- **`signingStatus(): array{keyed: bool, key_id: string}`** — cheap precondition check.

**Write path (`AuditChainLogger::append()`):** resolves the key, encodes/encrypts metadata *outside*
the lock, then takes the `audit_chain_append` lock (3s) to serialise read-latest-then-insert so two
concurrent appends cannot fork the chain. If the lock cannot be taken the row is still written
(best-effort ordering) — never drop an audit record. A configured-but-unresolvable key does **not**
silently fall through: the row is written unkeyed, an error is logged, and `hook_requirements()`
flags it. Set `stream_enabled` to also emit each row to the `audit_chain` logger channel.

## Request-scoped collector — do not log per access check

Hooks like `hook_entity_field_access()` fire per field, per entity, per render. Writing a row each
time floods a chain you cannot un-flood. Use `audit_chain.collector`
(`AuditChainCollector::collect($channel, $operation, $metadata, ?$dedupeKey)`):

- Deduplicates per request; **first occurrence wins** (metadata kept, later ones discarded, not
  merged). Default dedupe key = `channel:operation:entity_type:id`.
- `AuditChainFlushSubscriber` drains it once at `kernel.terminate` (after the response, so the chain
  lock stays off the request critical path). `flush()` clears the buffer before writing, so it is
  safe to call twice and cannot double-write.

## Verifying — `verify(): array`

Walks the whole chain in `id` order (no channel argument — the chain is global). Returns an additive
verdict: `ok, broken_at, reason, unkeyed_rows, unkeyed_through, verified_from, sealed_through,
seal_intact`. `reason` is one of the `REASON_*` constants:

- **`tampered`** — a row's content or ordering no longer matches its hash (`broken_at` names the row).
- **`written_unkeyed`** — rows are intact and in order but were hashed **without** the configured key
  (usually an unresolvable Key entity at write time). A different diagnosis and remedy than tampering.
- **`seal_broken`** — a sealed prefix's stored hashes changed since sealing (tampering of history).
- **`seal_foreign`** — sealed prefix digest matches but its MAC cannot be authenticated with a local
  key (expected after a cross-environment DB refresh; fail-closed but not evidence of change).

Integrity is checked with `matchesAnyKey()`, which tries **every** key the site holds (current +
`previous_hash_keys`) with `hash_equals`. The row's own `key_id` column only orders which key is
*tried first* — it is never trusted as authority, because it is not covered by the row hash.

## Seal / re-encrypt / prune

- **`sealPrefix(int $throughId, string $reason): array`** — records a site-local genesis anchor
  (in state, key `audit_chain.seal`, MAC'd with the active key) over stored `row_hash` values for
  ids ≤ `throughId`. Refuses if no key resolves, if any covered row still verifies under a configured
  key, or on bad input. Writes its own audit row (`channel=audit_chain`, `operation=prefix_sealed`).
  Post-seal verification skips content recompute for the prefix but detects any change to its hashes.
- **`reencrypt(string $from, string $to, int $limit = 0): array`** — rewrites `metadata` +
  `encryption_profile` for rows on `$from` to `$to`. **Never touches `row_hash`/`prev_hash`** (the
  chain covers plaintext). Idempotent; refuses if either profile will not load or they are equal.
- **`decodeMetadata(string $stored, string $profile = ''): array`** — decrypts using the row's own
  profile first, then the configured one, then plaintext JSON.
- **`prune(string $channel, int $retentionDays): int`** — deletes a channel's rows older than the
  cutoff. Deleting necessarily breaks the chain at that boundary (inherent to append-only); `verify()`
  reports the seam. Export first if history must stay provable.
