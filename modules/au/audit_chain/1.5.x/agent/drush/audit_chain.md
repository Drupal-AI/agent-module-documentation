<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit Chain — Drush commands

Provided by `AuditChainCommands`. **The exit code is the contract**: a non-zero status from `verify`/`export`
means the operation did not succeed, so it wires straight into monitoring or a deploy gate without parsing output.

## `audit-chain:verify` (alias `acv`)

Walks every entry and verifies the hash chain. No options.
- Exit 0: chain OK (message notes the entry count, and any active seal + `verified_from`).
- Exit 1 with distinct diagnoses:
  - **SEAL BROKEN** — the sealed prefix's stored hashes changed since sealing (tampering of historical evidence).
  - **UNSIGNED** (`written_unkeyed`) — N rows were hashed without the configured key (usually a Key entity that didn't resolve). The chain is internally consistent and unedited, but those rows can be rewritten by anyone with DB access. Cannot be signed retrospectively; seal them instead.
  - **BROKEN at row id N** — an entry was inserted, deleted or edited since it was written (true tampering).

## `audit-chain:seal` (alias `acs`)

Records a keyed digest over the *stored* `row_hash` values of a historical prefix that does not verify under the
configured keys (typically pre-key unkeyed production rows), so it is not re-chained or silently "repaired". Post-seal
`verify` content-checks only rows after the seal; editing a sealed hash later fails as SEAL BROKEN. Refuses to seal a
row that still verifies. Permanent site state.
- `--through=<id>` (required): highest row id to include (inclusive).
- `--reason="…"` (required): operator reason, stored on the seal and in an audit entry (`channel=audit_chain`, `operation=prefix_sealed`).
- `--yes`: skip the confirmation prompt.
- Example: `drush audit-chain:seal --through=1997 --reason="pre-key unkeyed production segment"`.

## `audit-chain:reencrypt` (alias `acre`)

Re-encrypts stored `metadata` from one EncryptionProfile to another. Never touches `row_hash` or any hashed column —
a storage transform, not a rewrite of history. Rows already on `--to` or plaintext are skipped. Refuses to start
unless both profiles load. Safe to re-run; use `--limit` for resumable batches until "remaining" is 0.
- `--from=<profile_id>` (required), `--to=<profile_id>` (required), `--limit=<n>` (0 = all).
- Non-zero exit if any row failed.
- Example: `drush audit-chain:reencrypt --from=old_profile --to=new_profile --limit=500`.

## `audit-chain:export` (alias `ace`)

Exports chain rows to an off-system evidence destination as data-minimized NDJSON (identifiers + hash-chain columns
only — never `metadata`, IPs, user agents, labels). One object per row, each stamped `contract_version` (currently 1).
**Delivery is at-least-once**: a per-destination checkpoint advances only after a successful delivery, so a re-run
after a failure retries the same rows — consumers must **deduplicate on the row `id`**. **Refuses** while the last
scheduled verification is failing, and refuses plain `http://` to a non-loopback host.
- `--destination=<url|path>`: `https://` ingest URL (POSTed as one `application/x-ndjson` body) or a file path (appended under an exclusive lock). Defaults to config `export_destination`.
- `--from-id=<id>`: replay history from this row id instead of the checkpoint (the checkpoint never moves backwards).
- `--channel=<name>`: restrict to one channel partition.
- `--limit=<n>`: max rows this run (0 = all); checkpointing makes limited runs resumable.
- Non-zero exit on failure (checkpoint unchanged; re-run retries). Logged/checkpointed with credentials stripped from the destination.
- Examples: `drush audit-chain:export --destination=https://evidence.example.com/ingest` · `drush audit-chain:export --destination=/var/evidence/chain.ndjson --from-id=1`.

**Cron leg**: enabling `export_enabled` + `export_destination` (optional `export_channel`) exports automatically each
cron run; cron verifies before exporting, so a failure found on the same run already blocks the push.
