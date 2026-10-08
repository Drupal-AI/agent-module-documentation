<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Route Basic Auth — agent index

Adds **HTTP Basic authentication to configured routes** (gate staging/preview/API paths behind a username/
password). Config at `route_basic_auth.settings`; provides permissions. Version **2.1.0-beta1**. Core
`^11.3||^12`.

**Security (correct):** `CredentialsValidator` compares username+password with **`hash_equals()`**
(constant-time), fails closed if unset. **Basic auth is base64 (not encrypted) — ALWAYS use over HTTPS**;
store the expected credentials as **secrets** (settings.php/env); coarse gate, not per-user auth.
