<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Public Key Credential Source — agent index

**Stores WebAuthn public-key credential sources** (registered passkeys/keys: credential id, public key, sign
counter). Depends on `json_field`, `universal_device_detection`, `webauthn_framework`. Provides permissions.
Version **1.0.0-alpha7**. Core `^10||^11`.

Authentication-data — holds credential records (public key, not a secret) that gate a factor: protect access
(its permission); framework verifies signatures + enforces the sign counter (clone detection). Used by passkey
modules.
