<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Presigned URL creates AWS-style HMAC-SHA256 signed, expiring URLs for controlled file access.

---

Presigned URL provides functionality for handling presigned URLs — AWS-style signed, time-limited links that grant temporary access to a resource (e.g. a private file) without a session. It generates a signature and exposes a Drush command (`presigned-url:sign`) to mint URLs with an expiry.

Security: the signature is `hash_hmac('sha256', host:uri:date:expires:algorithm, $privateKey)` with an expiry (`psu-expires`) — a sound presigned-URL design; the private key must be stored securely (env-backed) since it gates all signed access. Depends on core `file`; supports Drupal 10.3+ and 11.

---

- Generate presigned URLs.
- Validate presigned URLs.
- Sign with HMAC-SHA256.
- Include an expiry.
- Grant temporary file access without a session.
- Mint URLs via `presigned-url:sign` Drush.
- Include host/uri/date/expires in the signature.
- Store the private key securely (env-backed).
- Depend on core `file`.
- Support Drupal 10.3+ and 11.
- Follow AWS-style presigning.
- Limit access by time.
- Protect private files
- Configure expiry
- Verify signatures.
- Support controlled access.
- Handle signed links.
- Gate access by signature
