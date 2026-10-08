#!/usr/bin/env bash
# Execution VERIFY: PASS when webform we_encrypt_task has element 'ssn' flagged encrypt=true
# in third_party_settings.webform_encrypt.element. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\webform\Entity\Webform;
  $w = Webform::load("we_encrypt_task");
  $cfg = $w ? ($w->getThirdPartySetting("webform_encrypt", "element") ?? []) : [];
  $ok = !empty($cfg["ssn"]["encrypt"]);
  print ($ok ? "PASS" : "FAIL") . " ssn=" . var_export($cfg["ssn"] ?? NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
