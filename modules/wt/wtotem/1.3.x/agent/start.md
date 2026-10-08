<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WebTotem — agent index

**WebTotem website-security monitoring integration**. Version **1.3.1**. Core `^8.8||^11`.

**SECURITY (1.3.1):** the API client sets Guzzle `'verify' => false` (TLS verification disabled) while sending an `Authorization: Bearer` token → MITM/token-leak. Remove it. Token env-backed.