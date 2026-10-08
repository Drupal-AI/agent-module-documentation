<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Nonce Generator — agent index

Generates **cryptographically-secure nonces** for use by other code (CSP nonces / one-time markers / anti-replay
tokens). Version **1.0.0**. Core `^10||^11`.

**Security-positive**, implemented correctly: nonce = `hash('sha256', random_bytes(16))` — seeded from the
**`random_bytes()` CSPRNG** (unpredictable; verified). No access role.
