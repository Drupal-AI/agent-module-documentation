<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sample Content — agent index

**Creates access-restricted demonstration/development content in production**. Depends on core `node`. Provides
permissions. Version **1.0.0**. Core `^10||^11`.

Content/access — **positive**: restricts samples via **`hook_node_access_records()`/grants** (the robust
node-access system, honoured by canonical, **Views, JSON:API and search** — not just the UI). Gate the view-samples
permission; rebuild grants when they change.
