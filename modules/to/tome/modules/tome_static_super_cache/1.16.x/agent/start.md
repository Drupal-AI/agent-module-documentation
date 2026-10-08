<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tome Static Super Cache — agent index

Makes Tome Static's cache survive routine cache clears and stops list cache tags (`node_list`)
from wiping View caches on every node save. Depends on `tome_static`. No settings form.

- **What it decorates, the "Smart tag based" Views cache plugin, and how to fully rebuild** →
  [api/caching.md](api/caching.md)

Key facts: Views cache plugin id is **`tome_static_super_cache_smart_tag`** ("Smart tag based").
To force a real full rebuild use the **"Fully clear caches"** button at
`/admin/config/development/performance` (the `tscr` / `tome:super-cache-rebuild` command exists
in code but is registered only for Drupal Console, not Drush).
