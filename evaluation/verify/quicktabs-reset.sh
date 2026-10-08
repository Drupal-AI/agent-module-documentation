#!/usr/bin/env bash
# Reset the Quick Tabs eval to a clean, known baseline between runs so each
# condition is independent: delete the `eval_tabs` quicktabs_instance config
# entity (if it exists) and rebuild caches. Modelled on pathauto-reset.sh.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $qt = \Drupal::entityTypeManager()->getStorage("quicktabs_instance")->load("eval_tabs");
  if ($qt) { $qt->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: quicktabs_instance eval_tabs removed"
