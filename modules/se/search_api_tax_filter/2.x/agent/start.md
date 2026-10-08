<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Taxonomy Filter (search_api_tax_filter) — agent index

Search API **pre-processor to index only content with configured taxonomy terms**. Version **2.0.0**.

**Scoping, not access control** — content excluded from the index is merely not-found-in-search, not
access-protected (still reachable by URL). Don't rely on it to hide sensitive content.