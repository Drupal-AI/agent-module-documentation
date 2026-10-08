#!/usr/bin/env bash
# Execution RESET: create an alias for /lna-fix-source then force its DB langcode to 'en'
# (bypassing the neutral storage) to simulate a legacy non-neutral alias, so verify FAILS
# until the agent neutralizes it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\path_alias\Entity\PathAlias;
  $s = \Drupal::entityTypeManager()->getStorage("path_alias");
  foreach ($s->loadByProperties(["path" => "/lna-fix-source"]) as $e) { $e->delete(); }
  PathAlias::create(["path" => "/lna-fix-source", "alias" => "/lna-fix-alias"])->save();
  // Directly set a non-neutral langcode in the DB to mimic a legacy alias.
  \Drupal::database()->update("path_alias")
    ->fields(["langcode" => "en"])
    ->condition("path", "/lna-fix-source")
    ->execute();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: /lna-fix-source alias present with legacy langcode=en"
