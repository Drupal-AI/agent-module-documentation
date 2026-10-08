<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTMX Extras — agent index

**HTMX features** — access-checked entity lazy-loading + HTMX views. Version **1.0.7**. Core `^11.2`.

Lazy-load checks `$entity->access('view')` (respects access). Note: `revision_id` path checks only default view access, not revision-view — can expose historical revisions of published entities to users lacking `view revisions`. Admin perm `administer htmx_view`.