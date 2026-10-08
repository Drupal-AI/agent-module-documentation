#!/usr/bin/env bash
# Execution VERIFY: PASS when at least one enabled Activity config entity maps the User entity
# (entity_type=user) via the 'mail' property. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("mailchimp_transactional_activity");
  $ok = FALSE; $id = "none";
  foreach ($s->loadMultiple() as $e) {
    if (($e->entity_type ?? "")==="user" && ($e->email_property ?? "")==="mail" && !empty($e->enabled)) { $ok = TRUE; $id = $e->id(); break; }
  }
  print ($ok ? "PASS" : "FAIL") . " match=" . $id . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
