<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Session Entity — agent index

Provides an **entity type stored in the user's session** (per-visit ephemeral data, incl. anonymous). Provides
permissions. Version **2.x** (dev). Core `^8.8||^9||^10||^11`.

Developer/data — data lives in the **session** (ephemeral, per-user, not persistent); avoid storing sensitive
data in the session (only as protected as the session store). No broad access role beyond permission.
