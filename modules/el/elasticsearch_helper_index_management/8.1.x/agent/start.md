<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Elasticsearch Helper Index management — agent index

UI/tools for **managing Elasticsearch index plugins** (create/update/reindex/delete) defined via
**Elasticsearch Helper**. Depends on `elasticsearch_helper`. Version **8.1.1**. Core `^10||^11`.

Admin/search-backend tool — index ops (reindex/delete) are impactful; **restrict to trusted admins**;
protect the ES connection credentials (in Elasticsearch Helper). No content-access role.
