<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity 404 — agent index

Renders the **404 page when accessing an entity that fails configured conditions** (hide entities as
not-found; 404 vs 403 avoids confirming existence). Provides permissions. Version **1.1.2**. Core `^10||^11`.

Access-adjacent — governs the **rendered page response**, **not** real entity access control (the entity still
exists / may be reachable via other routes/APIs/listings). Pair with proper access control.
