<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Folder Tree — agent index

**Interactive AJAX UI for browsing the server directory/file hierarchy**, rooted at an admin-configured path.
Depends on core `system`. Provides permissions. Version **1.1.1**. Core `^10||^11`.

Administration — reads the **server filesystem** but **confines to `root_path`** via `realpath()` +
`str_starts_with($realPath, $realRoot)` (proper traversal protection). Still exposes filesystem names to permitted
users: grant `access folder tree` only to trusted admins; narrow `root_path` (not `/`).
