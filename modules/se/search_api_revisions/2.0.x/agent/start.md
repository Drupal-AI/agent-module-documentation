<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API - revisions — agent index

A Search API **datasource for indexing content-entity revisions** (search historical revisions, not just the
current version — auditing). Depends on `search_api`. Version **2.0.0-alpha4**. Core `^10.3||^11`.

**SECURITY CAVEAT:** indexing revisions can expose **unpublished/draft/old** content — ensure the index +
search display **respect access and revision status** (don't surface drafts a user shouldn't see); be
deliberate about which revisions are indexed and who can search them. No access role of its own.
