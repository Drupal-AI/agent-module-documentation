<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node Token Filter — agent index

A **text filter that replaces node/group tokens using the entity of the current URL** (`[node:…]` resolves
against the page being viewed). Depends on core `filter`, `token`. Version **1.1.0**. Core `^10||^11`.

Content-display/filter — resolves against the **current-URL (accessible) entity** via sanitizing token
replacement (not arbitrary entities); place on **trusted text formats**. No access role.
