#!/usr/bin/env bash
# Execution VERIFY: PASS when user dbee_new exists, its email loads as the plaintext
# dbee_new@example.com, AND the raw users_field_data.mail column is NOT that plaintext (i.e.
# dbee encrypted it at rest). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $u = user_load_by_name("dbee_new");
  if (!$u) { print "FAIL no-user\n"; return; }
  $loaded = $u->getEmail();
  $raw = \Drupal::database()->query("SELECT mail FROM {users_field_data} WHERE uid = :uid", [":uid" => $u->id()])->fetchField();
  $ok = ($loaded === "dbee_new@example.com" && $raw !== "dbee_new@example.com" && strlen((string) $raw) > 40);
  print ($ok ? "PASS" : "FAIL") . " loaded=" . $loaded . " raw_plain=" . ($raw === "dbee_new@example.com" ? "yes" : "no") . " raw_len=" . strlen((string) $raw) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
