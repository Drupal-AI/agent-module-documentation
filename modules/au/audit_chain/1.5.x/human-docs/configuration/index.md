# Configuration

All settings live on one form.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → System → Audit Chain**, or navigate directly to
   `/admin/config/system/audit-chain`.

The settings are stored in the `audit_chain.settings` config object; you can also set them
from the CLI with `drush config:set audit_chain.settings <key> <value>`.

## Signing and keys

- **Signing key** — the Key entity that provides the HMAC signing secret. Leave it empty
  and entries are hashed with plain SHA‑256, which detects accidental or careless edits
  only (anyone with database access could recompute the hashes after a change). Prefer a
  **File or Environment** key provider so the key lives outside the database.
- **Retired signing keys** — keys this chain was signed with previously. Verification still
  accepts them, so rotating the signing key does not make earlier rows look tampered with.
  Removing a key here makes the rows it signed unverifiable, so retire deliberately.

## Encryption at rest

- **Encryption profile** — an Encrypt module profile used to encrypt entry metadata at
  rest. Empty means metadata is stored in plaintext. **Changing this orphans existing
  rows**: old ciphertext can no longer be decrypted and those rows stop verifying, so
  export or re‑encrypt (`drush audit-chain:reencrypt`) before switching. The status report
  warns when rows still reference a profile the site no longer uses.

## Streaming to a log channel

- **Stream entries** — when on, each entry is also emitted to the `audit_chain` logger
  channel as a structured record, so a SIEM can pick it up via syslog/Monolog without
  polling the table.

## Scheduled verification

- **Verification interval (seconds)** — how often cron runs a full‑chain verification. `0`
  disables it. A failed run raises a status‑report **error**, logs to the `audit_chain`
  channel, and dispatches an event so you can wire your own alerting; a schedule that has
  gone quiet or never run raises a **warning**. The chain itself is never modified by the
  check.
- **Require keyed verification** — an assurance profile: when on, scheduled verification
  *fails* rather than silently falling back to unkeyed SHA‑256 if no signing key resolves,
  and fails if any rows were written unkeyed. Pair it with a signing key and a non‑zero
  interval.

## Off‑system evidence export

- **Enable export** — push new chain rows off‑system on each cron run. Requires a
  destination.
- **Export destination** — an `https://` ingest URL (one NDJSON POST per batch) or a
  server file path (appended safely). Plain `http://` is refused except to loopback. Only
  identifiers and hash‑chain columns leave — metadata, IPs, user agents, and labels never
  do.
- **Export channel** — restrict the cron export to a single channel; empty exports all
  channels. (On‑demand `drush audit-chain:export` takes its own `--channel`.)

Export is deliberately refused while the last scheduled verification is failing, so
unverified rows are never presented as evidence.

## After saving

Check the **Status report** (`/admin/reports/status`) — Audit Chain flags a signing key
that will not resolve, an active historical seal, rows under a retired encryption profile,
and the health of scheduled verification. For the sealing, re‑encryption, and export
commands, see the sibling [`agent/`](../agent/start.md) docs.
