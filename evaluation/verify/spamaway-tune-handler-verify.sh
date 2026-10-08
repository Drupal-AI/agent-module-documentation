#!/usr/bin/env bash
# Execution VERIFY: PASS when webform spamaway_eval_h2's SpamAway handler has
# spamaway_ip_check_enabled falsey AND spamaway_anti_spam_allowed_count == 3. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\webform\Entity\Webform;
  $w = Webform::load("spamaway_eval_h2");
  $ip = NULL; $count = NULL; $ok = FALSE;
  if ($w) {
    foreach ($w->getHandlers() as $h) {
      if ($h->getPluginId() === "spamaway_anti_spam_forms") {
        $s = $h->getConfiguration()["settings"];
        $ip = $s["spamaway_ip_check_enabled"] ?? NULL;
        $count = $s["spamaway_anti_spam_allowed_count"] ?? NULL;
        $ok = (empty($ip) && (string) $count === "3");
      }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " ip_check=" . var_export($ip, TRUE) . " allowed_count=" . var_export($count, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
