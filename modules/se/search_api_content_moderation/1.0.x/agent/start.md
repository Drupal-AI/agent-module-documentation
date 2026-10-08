<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Content Moderation — agent index

Adds a **Content Moderation processor to Search API** (index/filter by moderation state — e.g. only index
published/approved content). Depends on `search_api`, core `content_moderation`. Version **1.0.1**. Core
`^8||^9||^10||^11`.

Search (access-relevant) — **configure so drafts aren't exposed** via search (index/filter by state; indexing
draft content without filtering is a disclosure risk). No access role of its own.
