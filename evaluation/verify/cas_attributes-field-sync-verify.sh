#!/usr/bin/env bash
# Execution VERIFY: PASS when sitewide token support is on and limited to the two named
# attributes, and the user's e-mail is mapped from [cas:attribute:mail] on every login with
# overwrite enabled. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("cas_attributes.settings");
  $sitewide = $c->get("sitewide_token_support");
  $allowed = array_map("mb_strtolower", (array) $c->get("token_allowed_attributes"));
  sort($allowed);
  $freq = (int) $c->get("field.sync_frequency");
  $overwrite = $c->get("field.overwrite");
  $mail = $c->get("field.mappings.mail");
  $mailOk = is_string($mail) && preg_match("/\[cas:attribute:mail\]/i", $mail);
  $ok = ($sitewide === TRUE) && ($allowed === ["displayname", "mail"])
    && ($freq === 2) && ($overwrite === TRUE) && $mailOk;
  print ($ok ? "PASS" : "FAIL") . " sitewide=" . var_export($sitewide, TRUE)
    . " allowed=" . implode(",", $allowed)
    . " field.sync_frequency=" . $freq
    . " overwrite=" . var_export($overwrite, TRUE)
    . " mail=" . var_export($mail, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
