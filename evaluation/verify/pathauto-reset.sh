#!/usr/bin/env bash
# Reset pathauto to a clean, known baseline between eval runs so each condition is
# independent: delete every pathauto_pattern, clear /blog/* and /users/* aliases, and
# restore the pathauto.settings keys the tests touch to their install defaults.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("pathauto_pattern")->loadMultiple() as $p) { $p->delete(); }
  \Drupal::database()->delete("path_alias")->condition("alias", "/blog/%", "LIKE")->execute();
  \Drupal::database()->delete("path_alias")->condition("alias", "/users/%", "LIKE")->execute();
  \Drupal::configFactory()->getEditable("pathauto.settings")
    ->set("separator", "-")->set("max_length", 150)->set("transliterate", TRUE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: pathauto patterns + settings restored to baseline"
