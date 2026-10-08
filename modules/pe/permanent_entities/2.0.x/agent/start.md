<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permanent Entities — agent index

**Provides entities that cannot be created or deleted** (protected must-always-exist content). Provides
permissions. Version **2.0.0-beta7**. Core `^10||^11`.

Data-integrity/protection — blocks create + delete (guards critical entities). Verify the restriction covers UI +
API/programmatic delete paths; update may still be allowed. No broader access role.
