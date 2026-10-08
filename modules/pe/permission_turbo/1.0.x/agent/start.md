<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions Turbo — agent index

**High-performance replacement for the core permissions page** (lazy loading, instant search, delta-based
saving — 90%+ faster load) at `/admin/people/permissions-turbo`. Requires **PHP 8.1**; gated by
**`administer permissions`** (same as core). Provides permissions. Version **1.0.1**. Core `^10||^11`.

Admin UI tool — correctly permission-gated. **Verify delta-saving correctness** (edits apply exactly as
the core page would). Restrict `administer permissions` tightly (it controls all permissions).
