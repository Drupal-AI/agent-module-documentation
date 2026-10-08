#!/usr/bin/env bash
# Reset the Google Tag "second GA4 container" execution case to a clean baseline:
# delete the eval-owned google_tag_container config entities (eval_ga4, eval_container)
# so each run starts from nothing. Leaves any real containers untouched.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("google_tag_container");
  foreach (["eval_ga4", "eval_container"] as $id) {
    if ($c = $storage->load($id)) { $c->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: eval google_tag containers removed"
