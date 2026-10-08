<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OwnID — agent index

Provides **passwordless / biometric web authentication** via OwnID (passkeys/biometrics). Version **1.0.x**
(dev). Core `^10||^11`.

Authentication — **security-critical**: credentials as secrets (HTTPS), the OwnID assertion must be **validated
server-side** before a session (never trust a client claim), unambiguous mapping; **verify the flow** before
relying. Layers on core auth.
