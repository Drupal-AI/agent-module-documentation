#!/usr/bin/env bash
# Execution VERIFY: PASS when wmc_cfg has a mailchimp handler with double_optin === FALSE. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\webform\Entity\Webform;
  $w = Webform::load("wmc_cfg"); $ok = FALSE; $d = "none";
  if ($w) {
    foreach ($w->getHandlers() as $h) {
      if ($h->getPluginId() === "mailchimp") {
        $d = $h->getConfiguration()["settings"]["double_optin"] ?? "none";
        if ($d === FALSE) { $ok = TRUE; }
      }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " double_optin=" . var_export($d, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
