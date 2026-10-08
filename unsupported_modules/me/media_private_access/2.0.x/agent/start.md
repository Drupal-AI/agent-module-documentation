<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Private Access — agent index

Adds a **media entity access handler** restricting media view to admins/owner/`view <type> media`
permission-holders. Depends on core `media`. Provides permissions. Version **2.0.x** (dev). Core `^10.3||^11`.

Access-control — **media ENTITY access is real/correct** (properly forbids; respected by standalone pages +
Views/JSON:API). **Caveat**: it does NOT protect **file bytes** — no `hook_file_download`, no private-scheme
requirement, so **`public://` files remain directly downloadable by URL** (bypass). Use the **`private://`**
scheme for genuine file protection. Layers on core media access.
