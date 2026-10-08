#!/usr/bin/env bash
# Execution VERIFY: PASS when user dbee_upd now has email dbee_upd_new@example.com (loads as
# plaintext) AND its raw mail column is encrypted (not the plaintext). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $u = user_load_by_name("dbee_upd");
  if (!$u) { print "FAIL no-user\n"; return; }
  $loaded = $u->getEmail();
  $raw = \Drupal::database()->query("SELECT mail FROM {users_field_data} WHERE uid = :uid", [":uid" => $u->id()])->fetchField();
  $ok = ($loaded === "dbee_upd_new@example.com" && $raw !== "dbee_upd_new@example.com" && strlen((string) $raw) > 40);
  print ($ok ? "PASS" : "FAIL") . " loaded=" . $loaded . " raw_plain=" . ($raw === "dbee_upd_new@example.com" ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
