<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Hash — agent index

**Generates per-user hashes (CSPRNG)** usable as a bearer-token **authentication provider** (validates username
+ hash). Depends on core `user`. Provides permissions. Version **2.1.0**. Core `^10||^11`.

Auth — generation is sound: `hash($algo, random_bytes($n))` (**`random_bytes()` CSPRNG**, default sha256/32
bytes → unpredictable). The hash is a **bearer credential** (grants access as the user): HTTPS only, never in a
URL/query (logs), store securely, allow rotate/revoke.
