<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Anchors audit-trail chain heads to a qualified RFC-3161 Time-Stamping Authority; each round-trip lands as a chained tsa_timestamp row carrying the TSR, verifiable offline with openssl.

---

`audit_trail_tsa` gives an audit chain an external trust anchor. It builds an RFC-3161 TimeStampReq from the chain head's hash (via `openssl ts -query`), POSTs it to the configured TSA over Drupal's Guzzle `http_client`, captures the TimeStampResp, synchronously verifies it (`openssl ts -verify` against the provider's pinned CA cert, validating the nonce echo), and records a chained `tsa_timestamp` row storing the base64 TSR and TSQ plus their SHA-256s in the permanent bucket. Because the TSR is signed by a third-party key, forging the chain later would also require forging every historical timestamp. TSAs are `audit_trail_tsa_provider` config entities (endpoint URL, pinned CA cert, nonce toggle, and auth mode none/basic/bearer/mTLS with every credential resolved at request time from `drupal/key` entities). It runs from cron (per-chain throttle) or on demand from Drush and UI actions. Requires `audit_trail`, `drupal/key`, and the `openssl` binary on the host. Requires `audit_trail` and `key`.

---

- Add legally-defensible external timestamps to a compliance/notarial audit chain.
- Prove a chain existed in a given state at a given instant via a qualified TSA.
- Anchor chain heads automatically on cron at a configurable per-chain cadence.
- Timestamp a chain on demand with `drush audit_trail:timestamp --chain=X` (or `--all`).
- Configure a public TSA (e.g. FreeTSA) with just a URL and CA cert, no credentials.
- Authenticate to a commercial TSA with HTTP Basic, a bearer token, or mutual TLS.
- Keep all TSA credentials out of config export by referencing `drupal/key` entities.
- Verify a stored timestamp offline with `drush audit_trail:verify-timestamp --row-id=N`.
- Bulk-verify every TSA timestamp on a chain, or across all chains, from the UI.
- Rotate TSA providers while keeping historical timestamps verifiable (pending/active/inactive).
- Pin a CA cert chain per provider for `openssl ts -verify -CAfile` validation.
- Skip a chain's automatic timestamping (dev/debug streams) via per-chain third-party settings.
- Surface openssl availability and TSA reachability on the status report.
- Detect a swapped or replayed TSR because the original TSQ (with its nonce) is stored and re-checked.
