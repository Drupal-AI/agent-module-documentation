#!/usr/bin/env bash
# Execution VERIFY: PASS when the user 'mail' field is GDPR-enabled with rtf=anonymize and
# anonymizer=email_anonymizer in the gdpr_fields_config.user entity. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\gdpr_fields\Entity\GdprFieldConfigEntity;
  $c = GdprFieldConfigEntity::load("user");
  if (!$c) { print "FAIL no-config\n"; return; }
  $f = $c->getField("user", "mail");
  $ok = ($f->enabled && $f->rtf === "anonymize" && $f->anonymizer === "email_anonymizer");
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($f->enabled, TRUE) . " rtf=" . var_export($f->rtf, TRUE) . " anonymizer=" . var_export($f->anonymizer, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
