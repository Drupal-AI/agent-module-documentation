#!/usr/bin/env bash
# Reset for the "back-date an Article's publication date" task: delete any node titled
# 'PD Backdated Article' so the case starts from empty state (verify must FAIL before the
# agent builds anything). Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", "PD Backdated Article")->execute();
  if ($ids) { $storage->delete($storage->loadMultiple($ids)); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: removed any 'PD Backdated Article' node"
