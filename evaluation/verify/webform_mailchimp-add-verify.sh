#!/usr/bin/env bash
# Execution VERIFY: PASS when wmc_task has a mailchimp handler targeting list 'eval_list_777'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\webform\Entity\Webform;
  $w = Webform::load("wmc_task"); $ok = FALSE; $list = "none";
  if ($w) {
    foreach ($w->getHandlers() as $h) {
      if ($h->getPluginId() === "mailchimp") {
        $list = $h->getConfiguration()["settings"]["list"] ?? "none";
        if ($list === "eval_list_777") { $ok = TRUE; }
      }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " list=" . var_export($list, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
