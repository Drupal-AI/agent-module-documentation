<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `elasticsearch_helper.permissions.yml`.

| Permission | Machine name | Grants |
|------------|--------------|--------|
| Configure Elasticsearch Helper | `configure elasticsearch helper` | Access to the settings form route `elasticsearch_helper.elasticsearch_helper_settings_form` (`/admin/config/search/elasticsearch_helper`) — hosts, scheme, authentication method + credentials, SSL, and defer-indexing. |

Marked `restrict access: true` (administrative permission; the form edits connection credentials).
No other routes are gated by this module. Index management (`setup`/`drop`/`reindex`/`truncate`)
is exposed only through drush, not routes.
