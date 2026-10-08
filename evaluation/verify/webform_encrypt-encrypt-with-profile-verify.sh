#!/usr/bin/env bash
# Execution VERIFY: PASS when we_encrypt_task2 element 'notes' has encrypt=true AND
# encrypt_profile === we_test_profile. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\webform\Entity\Webform;
  $w = Webform::load("we_encrypt_task2");
  $cfg = $w ? ($w->getThirdPartySetting("webform_encrypt", "element") ?? []) : [];
  $n = $cfg["notes"] ?? [];
  $ok = (!empty($n["encrypt"]) && ($n["encrypt_profile"] ?? "") === "we_test_profile");
  print ($ok ? "PASS" : "FAIL") . " notes=" . var_export($n, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
