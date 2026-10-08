<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WordPress Migrate SQL — agent index

Migrates **WordPress content into Drupal directly from a WordPress SQL database** (posts/pages/taxonomies/
users via Migrate API — alternative to WXR). `wordpress_migrate_sql_basic` submodule; Drush. Depends on core
`migrate`. Version **1.0.1**. Core `^11.2`.

**Security:** connects to the WP DB with **credentials** — store securely (settings.php/env, not committed),
grant **read-only** where possible, run as a trusted operator; review/sanitize imported content. No access
role.
