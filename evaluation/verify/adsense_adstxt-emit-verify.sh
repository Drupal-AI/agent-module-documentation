#!/usr/bin/env bash
# Execution VERIFY: invoke the adsense_adstxt controller directly (no HTTP, no live Google) and
# PASS when its /ads.txt body contains the expected publisher ID and the DIRECT line. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  try {
    $c = \Drupal\adsense_adstxt\Controller\AdsenseAdsTxtController::create(\Drupal::getContainer());
    $resp = $c->display();
    $body = $resp->getContent();
  } catch (\Throwable $e) { $body = "EXCEPTION:" . $e->getMessage(); }
  $ok = (strpos($body, "ca-pub-2222333344445555") !== FALSE) && (strpos($body, "DIRECT") !== FALSE);
  print (($ok) ? "PASS" : "FAIL") . " body=" . str_replace("\n", " ", trim($body)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
