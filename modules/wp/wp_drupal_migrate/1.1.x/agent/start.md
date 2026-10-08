<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WordPress Drupal Migrate — agent index

Migrates **WordPress content into Drupal via a direct database connection** (posts/taxonomy/media/comments/
menus through the Migrate API). Depends on `migrate`, `migrate_plus`, `migrate_tools` + core content modules.
Provides permissions. Version **1.1.3**. Core `^10||^11`.

Developer/migration — holds **WordPress DB credentials** (store as secrets, trusted DB); apply safe text
formats to imported HTML; run on staging + review. No Drupal access role beyond permission.
