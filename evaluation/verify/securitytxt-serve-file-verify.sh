#!/usr/bin/env bash
# Live-state verification for "enable the security.txt file with a contact + encryption key".
# Renders the file the way the controller does (via the securitytxt.serializer service) and
# asserts the served body actually contains the Contact: mailto: and Encryption: lines.
# This proves the config is not just set but produces a valid served file. Exits 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $settings = \Drupal::config("securitytxt.settings");
  try {
    $body = \Drupal::service("securitytxt.serializer")->getSecuritytxtFile($settings);
  }
  catch (\Throwable $e) {
    // Disabled config throws NotFoundHttpException -> not served.
    print "\nFAIL served=0 reason=" . get_class($e) . "\n";
    return;
  }
  $has_contact = (bool) preg_match("/^Contact: mailto:.+@.+/m", $body);
  $has_enc     = (bool) preg_match("/^Encryption: https:\/\/.+/m", $body);
  $ok = $has_contact && $has_enc;
  print "\n" . ($ok ? "PASS" : "FAIL")
    . " contact=" . ($has_contact?1:0)
    . " encryption=" . ($has_enc?1:0) . "\n";
' 2>/dev/null)
echo "$out" | grep -E '^(PASS|FAIL)'
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
