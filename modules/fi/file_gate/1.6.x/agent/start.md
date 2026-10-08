<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Gate — agent index

**Gates access to private files** with pluggable methods (short-lived **HMAC-signed URLs**, authenticated access)
and delivers them to decoupled front ends. Depends on core `file`. Provides permissions. Version **1.6.1**. Core
`^11.4||^12`.

**Security-positive** — `hook_file_download()` **denies by default** (`-1`) unless a valid **HMAC-signed** grant
(`GrantSigner` over resource id + claims + secret, short TTL). Keep files on **`private://`** (public bypasses
gating), **store the signing secret securely** (a leak mints links), short TTLs, HTTPS.
