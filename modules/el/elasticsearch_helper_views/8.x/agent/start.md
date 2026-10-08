<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Elasticsearch Helper Views — agent index

Integrates **Elasticsearch (via Elasticsearch Helper) with Views** (query an ES index, render with Views
fields/filters). Depends on `elasticsearch_helper`. Version **8.x** (dev). Core `^9.4||^10||^11`.

Search/integration — results come from **Elasticsearch, not Drupal's entity access** (be careful what you
index/expose; filter for access at index time). No access role of its own.
