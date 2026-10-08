<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Chain construction, storage, verification, retention

## The chain invariant (per chain id)
For each row on a chain (`audit_trail.install` `hook_schema`):
- `previous_hash` = the previous row's `hash` (empty string at genesis).
- `hash` = SHA-256(canonical(payload columns incl. `secret_id`) ‖ `previous_hash`), hex. **Publicly verifiable — no secret needed.**
- `hmac` = HMAC-SHA-256(`hash`, secret(`secret_id`)). The operator signature on top of the public hash.

Canonicalisation lives in `AuditTrailVerifier::canonicalize()` and is reproduced by `ChainPayload::createFromRow()` on the detail page. Tampering with any signed column breaks `hash`; inserting a row without the secret breaks `hmac`.

## `audit_trail` row columns (signed unless noted)
`id`, `created` (µs since epoch, BIGINT), `channel` (originating PSR-3 channel), `chain` (chain-group id; defaults to channel), `severity` (RFC 5424 0–7), `action` / `resource` (first-class audit columns, NULL for non-audit rows), `context_permanent` (JSON, signed raw, never purged), `context_transient` (JSON, may hold PII; signed via `context_transient_hash`, NULLable at retention), `context_transient_hash`, `previous_hash`, `hash`, `hmac`, `secret_id`, `correlation_id` (indexed, **not** canonical). Unique key `(chain, previous_hash)` makes a fork fail at the DB (defence-in-depth behind the per-chain write lock). Indexes on `(chain,id)`, `resource`, `action`, `channel`, `severity`, `created`, `correlation_id`.

## Two retention tiers
- **Permanent**: operator-attested, PII-free metadata (action verbs, resource ids, structural flags). Signed raw inside the canonical; kept for full retention.
- **Transient**: raw operational payload (before/after diffs, IPs, request URIs, message template + placeholder values, actor uid). Signed by hash so the cron transient-purge can NULL the column at a short window without breaking verification. The verifier accepts a NULL transient column with a non-empty hash only when a covering `audit_trail_segment` attests the purge (`transient_purged_at` / `archived_at` set); an attacker NULLing to hide data has no such attestation and fails.

## Verifier (`src/AuditTrailVerifier.php`, service `audit_trail.verifier`)
Walks a chain in id order, recomputes both layers, reports every contiguous broken range in one pass. Incremental verification reads the last `audit_trail_checkpoint` (itself HMAC-signed) and walks only new rows, minting a fresh checkpoint on a clean walk; full verification cold-walks from genesis. Per-row `secret_id` dispatch lets one chain span rotated secrets. `audit_trail_acknowledgment` rows (HMAC-signed, anchor-pinned) let an operator mark a genuinely-unverifiable range accepted, so the verifier skips it with the recorded reason instead of a red verdict.

## Secrets (`src/Key/KeyBackedSecretRepository.php`, service `audit_trail.secret_repository`)
HMAC secrets are `audit_trail_secret` config entities whose `key_id` points at a `drupal/key` Key entity — byte material never lives in config export or DB dump (a state-backed secret would sit in the very DB the module detects tampering in, so Key is the only backend). Lifecycle: pending → active → retired. `rotate()` promotes the newest pending, then retires the previous active (activate-first so a mid-rotation crash leaves two actives, not zero). Activation refuses a Key shorter than 32 bytes. Every row records the `secret_id` it was signed with, so old rows keep verifying after rotation.

## Transaction safety (`in_transaction_write_mode`)
A write inside a caller's open transaction can't be serialised by the per-chain lock (the head read is bound to that transaction's snapshot). Modes: `outbox` (default) stages the row in `audit_trail_outbox` inside the transaction with a `content_hash`, and a post-commit flush chains it (a rollback drops the staged row atomically); `memory` holds it in memory (lost on crash; `keep_rolled_back_writes` can chain rolled-back entries marked as such); `inline` chains immediately (drops under concurrency; only for callers needing a failed write to abort their transaction).

## Retention lifecycle (cron, `src/Hook/AuditTrailCron*Hooks.php`, `src/Archive/*`)
Five stages with global defaults + per-chain overrides: **transient-purge** (NULL transient bytes early), **archive** (export a bucket to a signed NDJSON file under `archive_directory`, recording `file_sha256` + anchors in an `audit_trail_segment` row), **live-purge** (DELETE the live rows; the segment stays as the verifier skip-marker), **file-purge** (unlink the NDJSON; segment bookkeeping + anchors survive so the verifier bridges the empty range), **compaction** (fold contiguous file-purged segments). `DirectoryChecker` refuses a web-servable archive path (`public://`) since rows may carry PII; default `private://audit_trail`. Segment rows carry three independent HMACs (identity, archive-content, lifecycle-state) each with their own `secret_id`.
