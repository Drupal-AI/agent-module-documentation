<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Orphaned Files — agent index

Provides a **list of orphaned (unreferenced) managed files** (review/clean up unreferenced files). Depends on
core `file`. Provides permissions. Version **1.0.2**. Core `^10||^11`.

File-management/admin — report lists file paths (can be **sensitive** — gate to trusted admins); **verify**
files are truly unreferenced before deleting (untracked references exist). No access role beyond permission.
