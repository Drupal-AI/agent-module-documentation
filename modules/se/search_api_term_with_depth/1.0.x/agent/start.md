<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Term With Depth — agent index

A **Search API Views filter matching a taxonomy term and its descendants (depth)** (select a category → also
match its subcategories). Depends on `search_api`. Version **1.0.1**. Core `^10||^11`.

Search/query-convenience (reviewed CLEAN) — expands the term into descendant tids as query conditions; the
Search API query still applies index/View access; no access role.
