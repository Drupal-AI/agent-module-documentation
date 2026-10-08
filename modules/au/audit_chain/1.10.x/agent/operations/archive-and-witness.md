<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Archive checkpoints & external witnesses (new in 1.10)

Two service-only subsystems added in 1.10 (no routes, no Drush commands, no form). Both are
data-minimized and fail-closed. Background: `docs/ARCHIVAL_BOUNDARY.md` in the module.

## Archive-checkpoint bundles (`ArchiveBundleExporter`)

Service `audit_chain.archive_bundle_exporter` (`Drupal\audit_chain\ArchiveBundleExporter`). Builds a
deterministic, independently verifiable bundle over a **closed id window** of the global chain.
Contract `audit_chain.archive.v1` (`CONTRACT`), `CONTRACT_VERSION = 1`. JSON Schema shipped at
`docs/archive-bundle-v1.schema.json`.

- **`create(int $fromId = 1, ?int $throughId = NULL): array`** — runs under
  `AuditChainLogger::withChainLock()` so the window cannot move mid-read. Steps:
  1. Validates the window (positive, ascending ids).
  2. **Refuses** unless the chain verifies, or a successor segment exists and itself verifies
     (`segment_ok`) — a window over an unverified chain is never archived.
  3. Resolves `throughId` to the latest row when omitted; requires both boundaries to name stored rows.
  4. Reads **only** `id`, `prev_hash`, `row_hash` per row (plus `contract_version`). No metadata,
     IP, UA, label, channel, actor, entity id, operation, or key id is read or emitted.
  5. Builds a v1 Merkle tree — leaf = `SHA-256("audit_chain.archive.leaf.v1\n" + encoded row)`,
     node = `SHA-256("audit_chain.archive.node.v1\n" + left + right)`, an unpaired right leaf is
     duplicated — and an inclusion proof path for every row.
  6. Assembles the manifest: contract/version, `instance_id`, window (`from_id`/`through_id`/
     `row_count`), `hash_algorithm` `sha256`, `merkle_root`, `chain_head` (last row's `row_hash`),
     and bounded commitments to any **prefix seal** and **successor record** (digests only — the
     seal MAC and manifest text are hashed, never exported in the clear).
  7. `digest = SHA-256("audit_chain.checkpoint.v1\n" + canonical manifest without digest)`, then
     persists one checkpoint row (idempotent on `digest`) in `audit_chain_checkpoint`.
- **Return value**: `manifest`, minimized `rows`, `merkle` (root/leaves/proofs) and a human-readable
  `verification` recipe for offline replay. **No row content or signing material is returned.**
- **Requires `audit_chain_instance_id`** in `settings.php` (same identity as recovery), non-empty and
  ≤ 255 bytes, or it throws.
- **JSON** is frozen for the contract: `JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE |
  JSON_THROW_ON_ERROR`, no lossy fallback.

`audit_chain_checkpoint` columns: `digest` (PK), `contract_version`, `from_id`, `through_id`,
`row_count`, `created`, `manifest`. The same closed window always re-derives the same digest.

## External witnesses (`WitnessManager`)

Service `audit_chain.witness_manager` (`Drupal\audit_chain\WitnessManager`). Submits a **checkpoint
digest only** to a pluggable external witness and persists an opaque receipt — never audit rows,
metadata or channel names. Backends are collected on the `audit_chain.witness_backend` tag (method
`addBackend`) and keyed by `id()`.

- **`submit(string $digestHex): WitnessReceipt`** — requires a lowercase 64-hex SHA-256 digest that
  **already exists** in `audit_chain_checkpoint`, resolves the configured backend (config
  `witness_backend`, empty → the `null` backend), calls `backend->submit($digest, ['contract' =>
  'audit_chain.checkpoint.v1'])`, and inserts the receipt into `audit_chain_witness_receipt`.
- **`receipt($id)`, `upgrade($id)`, `verify($id, $digestHex)`** — load/advance/verify a persisted
  receipt. `verify()` fail-closes: missing receipt → `receipt_missing`; stored digest ≠ supplied →
  `checkpoint_digest_mismatch`; an unconfirmed receipt → `receipt_not_confirmed`; otherwise defers to
  the backend's `WitnessVerdict`. An upgrade may never change a receipt's identity or backend.
- **`WitnessReceipt`** (immutable value) — `id` (≤128), `backendId` (≤64), `status`
  (`submitted`/`pending`/`confirmed`), `opaqueToken`. **`WitnessVerdict`** — `valid` (bool) + `reason`.

`audit_chain_witness_receipt` columns: `id` (PK), `checkpoint_digest`, `backend_id`, `status`,
`submitted`, `updated`, `opaque_token`.

### `NullWitnessBackend` — the fail-closed default

`audit_chain.witness_backend.null`, id `null`. Makes **no network request**, returns a `pending`
receipt with an empty token on submit, is a no-op on upgrade, and its `verify()` always returns
`WitnessVerdict(FALSE, 'backend_not_configured')`. Until a live backend is configured, witness
verification never passes — missing configuration is never treated as success. No witness operation
writes an audit-chain row.
