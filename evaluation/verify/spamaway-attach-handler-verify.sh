#!/usr/bin/env bash
# Execution VERIFY: PASS when webform spamaway_eval_h1 has a handler of plugin id
# spamaway_anti_spam_forms. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\webform\Entity\Webform;
  $w = Webform::load("spamaway_eval_h1");
  $found = FALSE;
  if ($w) {
    foreach ($w->getHandlers() as $h) {
      if ($h->getPluginId() === "spamaway_anti_spam_forms") { $found = TRUE; }
    }
  }
  print ($found ? "PASS" : "FAIL") . " handler_present=" . var_export($found, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
