#!/usr/bin/env bash
# Execution VERIFY: PASS when a Template Map exists with mailsystem_key 'default-system' and
# template_name 'newsletter'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("mailchimp_transactional_template");
  $ok = FALSE; $id = "none";
  foreach ($s->loadMultiple() as $e) {
    if (($e->mailsystem_key ?? "")==="default-system" && ($e->template_name ?? "")==="newsletter") { $ok = TRUE; $id = $e->id(); break; }
  }
  print ($ok ? "PASS" : "FAIL") . " match=" . $id . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
