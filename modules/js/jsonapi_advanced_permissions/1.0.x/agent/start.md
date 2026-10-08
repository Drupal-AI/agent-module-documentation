<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON:API Advanced Permissions — agent index

Adds **dynamic per-collection, per-HTTP-method permissions** to **JSON:API** — generates permissions
(GET/POST/PATCH/DELETE × collection) and gates the routes via a route subscriber (**fail-closed**).
Depends on core `jsonapi`; config at `jsonapi_advanced_permissions.settings`. Version **1.0.0-rc2**.
Core `^10||^11`.

Governs JSON:API *routes/collections* — **complements, not replaces** entity/field access; keep both
correct. Provides permissions.
