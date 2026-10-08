<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Verification — agent index

An **API for verifying operations**, with a **security-hardened** `verification_hash` provider. Version
**2.0.0-rc5**. Core `^10.3||^11`.

**Security-positive** — `verification_hash` follows core's one-time-link model: HMAC (`Crypt::hmacBase64`)
**keyed on `Settings::getHashSalt()` + the password hash** (invalidated on password change), **expiry**,
**`hash_equals()`** compare, and login-mode **last-login binding** (verified). Use it instead of ad-hoc tokens.
No access role of its own.
