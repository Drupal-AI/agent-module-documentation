#!/usr/bin/env bash
# Execution RESET for the "create a single named leaf forum" task: remove any term named
# "Support" from the `forums` vocabulary so verify starts from a state where the target
# forum does not exist. Leaves the rest of the board untouched.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  foreach ($storage->loadByProperties(["vid" => "forums", "name" => "Support"]) as $t) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: any forums-vocabulary term named 'Support' removed"
