<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Access Hub — agent index

**Central-hub authentication spoke** (signed `/spoke/api/*`). Version **1.0.11**. Core `^9||^10||^11`.

`/spoke/api/*` are `access content` but each verifies an **openssl SHA-384 signature** against the hub's public key before acting (incl. `addRole()`) — signature is the real gate (positive). Minor: secondary `== $api_key` is non-constant-time. Keys env-backed. Config perm `administer user access hub configuration`.