<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DNS — extras: the specialty record-type plugins

`dns_extras` adds `RecordType` plugins consumed by the parent module's `RecordTypeManager` (see the parent doc `../../../2.0.x/agent/plugins/record-types.md`). No config, routes, services, or permissions — pure plugin discovery. Enable with `drush en dns_extras`, clear caches, and the types appear in the record form's Type select.

## DNAME (`Dname`)

Extends `RecordTypeBase` and uses `TargetHostnameTrait`. `usedFields()` → `['target']`; `validateForm()` calls `validateBindTarget()`; `renderSummary()` → the BIND target. Same shape as core CNAME/NS/PTR — a single target hostname, no `rdata`. Aliases an entire subtree (RFC 6672).

## `HashRecordTypeBase` — the hash-digest / key family

Shared abstract base (`src/Plugin/RecordType/HashRecordTypeBase.php`) for "integer headers + one binary payload" types. `usedFields()` → `[]` (everything in `rdata`).

- Subclasses declare `headers()` (ordered map of `rdata` key → `['label' => …, 'max' => N]`; lower bound implicitly 0; `255` = uint8, `65535` = uint16) and `payloadEncoding()` (`hex` or `base64`) plus `payloadLabel()`.
- `buildForm()` renders a `number` element per header (`#min 0`, `#max` from the spec) and a textarea for the payload (`data` rdata key, `#maxlength` 8192).
- `validateForm()` range-checks each header (`validateHeader()`) and validates the payload (`validatePayload()`): non-empty, ≤8192 chars after whitespace strip, matches `^[0-9a-fA-F]+$` for hex, or `^[A-Za-z0-9+/]+={0,2}$` plus a `base64_decode(strict)` round-trip for base64.
- `applyToRecord()` normalizes (`normalizePayload()`: strip whitespace; lowercase hex; base64 kept as-is) and writes headers + payload to `rdata` (`PAYLOAD_KEY = 'data'`).
- `renderSummary()` emits BIND zone-file order: header integers space-separated then the payload, truncated at 32 chars for list display.

## The six hash-family types (headers → payload encoding)

- **SSHFP** (`Sshfp`, RFC 4255) — `algorithm` (0–255), `fp_type` (0–255) → **hex**. SSH host-key fingerprint.
- **TLSA** (`Tlsa`, RFC 6698) — `cert_usage`, `selector`, `matching_type` (each 0–255) → **hex**. DANE TLS cert pinning; `_<port>._<proto>.<host>` convention.
- **SMIMEA** (`Smimea`) — same header shape as TLSA → **hex**. S/MIME cert association.
- **OPENPGPKEY** (`Openpgpkey`) — no headers → **base64**. OpenPGP public key.
- **DS** (`Ds`) — delegation-signer headers → key digest. Links a child zone into the DNSSEC chain.
- **DNSKEY** (`Dnskey`) — DNSSEC key headers → **base64** key material.

(Exact header sets for DS/DNSKEY/SMIMEA are declared in each plugin's `headers()`.)

## Adding more

Any module can add further types the same way — drop a `#[RecordType]` class in `Plugin/RecordType/`, extending `RecordTypeBase` or `HashRecordTypeBase`. See the parent module's plugin doc.
