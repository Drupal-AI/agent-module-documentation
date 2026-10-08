#!/usr/bin/env bash
# Execution RESET for the "build a forum container + forum" task: clear the board so the
# verify starts from empty state. Deletes EVERY term in the `forums` vocabulary and
# restores forum.settings to install defaults. The site has no forum content, so this is
# safe between eval runs.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  foreach ($storage->loadByProperties(["vid" => "forums"]) as $t) { $t->delete(); }
  \Drupal::configFactory()->getEditable("forum.settings")
    ->set("topics.page_limit", 25)->set("topics.hot_threshold", 15)
    ->set("topics.order", 1)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: all forums-vocabulary terms removed; forum.settings restored to defaults"
