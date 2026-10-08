#!/usr/bin/env bash
# Execution RESET for "whitelist the radios element type via hook_prepopulate_whitelist_alter".
# Uninstalls and deletes the prepopulate_eval helper module so the live whitelist is back to the
# stock 18 types (no "radios"). Only touches web/modules/custom/prepopulate_eval.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall prepopulate_eval -y >/dev/null 2>&1
rm -rf /var/www/html/web/modules/custom/prepopulate_eval
drush cr >/dev/null 2>&1
drush php:eval '
  $s = \Drupal::service("prepopulate.populator");
  $p = (new ReflectionClass($s))->getProperty("whitelistedTypes"); $p->setAccessible(TRUE);
  print "reset: whitelist has " . count($p->getValue($s)) . " types, radios=" . (in_array("radios", $p->getValue($s)) ? "yes" : "no") . "\n";
' 2>/dev/null
exit 0
