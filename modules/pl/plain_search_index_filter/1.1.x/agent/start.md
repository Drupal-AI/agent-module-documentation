<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plain Search Index Filter — agent index

Twig **filter that strips HTML cleanly for search indexing** (remove tags + `<script>`/`<style>` contents,
add breaks between tags → clean plain text). Config at `plain_search_index_filter.settings`. Version
**1.1.0**. Core `^10||^11`.

Site-search/indexing helper — processes text for the index; no access role.
