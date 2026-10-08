<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cryptolog enhances user privacy by replacing client IP addresses with ephemeral, keyed-hash identifiers, so raw IPs are not stored in Drupal logs or database tables.

---

Cryptolog is a privacy-enhancing module that registers an HTTP stack middleware (`cryptolog.middleware`, priority 222) which, on each main request, replaces the client IP returned by `\Drupal::request()->getClientIp()` with a 128-bit keyed hash of the real IP rendered in IPv6 notation. The hash is keyed by a random 32-byte salt cached under key `cryptolog` and regenerated every TTL period (default 86400s / 24h), so the same visitor maps to a stable pseudonym for the salt's lifetime and a new one after rotation. Hashing uses the Sodium extension (`sodium_crypto_generichash`, BLAKE2b) when available, otherwise falls back to `hash_hmac('md5', …)`. Because the pseudonym is stable within a TTL window, statistics like unique-IP counts per day and Drupal's IP-based flood control keep working. It is configured at `cryptolog.settings` (`/admin/config/people/cryptolog`), which exposes salt storage/TTL options plus reverse-proxy diagnostics. Single-web-node sites can store the salt solely in APCu (never on disk) via the `single_webhead` setting; multi-node sites keep the default shared cache backend (use Memcache/Redis to avoid disk). Note the README caveat: while the salt is retrievable, a rainbow-table brute force of IPv4 space is possible; once the salt expires or is lost from memory, IPs cannot be recovered.

---

- Replace client IPs with ephemeral keyed-hash IDs before Drupal reads them.
- Keep raw IPs out of Drupal logs (dblog), sessions, and DB tables.
- Reduce the personal-data footprint for GDPR/CCPA data minimization.
- Pseudonymize visitor IPs while keeping short-term correlation.
- Count unique IPs per day using the stable per-salt pseudonym.
- Keep IP-based flood control (login/user) working across the TTL window.
- Configure the salt TTL at `cryptolog.settings`.
- Rotate the salt automatically on TTL expiry to prevent rainbow-table reversal.
- Regenerate the salt on demand via the "Regenerate salt now" checkbox on the settings form.
- Store the salt solely in APCu on a single web node (`single_webhead`).
- Share the salt across web nodes via Memcache/Redis, off disk.
- Set TTL larger than the flood-control window (form enforces a min from `user.flood`).
- View the current storage backend class and time-to-expiry in the UI.
- Diagnose reverse-proxy scheme/host restoration on the settings page.
- Confirm the original (pre-hash) client IP for the current request in diagnostics.
- Use Sodium BLAKE2b generic-hash when the extension is available.
- Fall back to HMAC-MD5 hashing when Sodium is absent.
- Verify PHP has IPv6 support (install requirement, IPv6 notation output).
- See a status-report warning when the salt TTL is shorter than the flood window.
- Weigh loss of true-IP features (geolocation, IP allow-lists, forensics).
- Apply a positive privacy control with no negative access implications.
- Anonymize logged IPs on Drupal 11.2+ / 12.
