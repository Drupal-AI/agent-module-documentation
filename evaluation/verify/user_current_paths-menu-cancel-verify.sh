#!/usr/bin/env bash
# Execution VERIFY: PASS when a menu_link_content in menu 'account' targets
# internal:/user/current/cancel. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  $ok = FALSE; $id = "";
  foreach ($s->loadByProperties(["menu_name" => "account"]) as $l) {
    if ($l->get("link")->uri === "internal:/user/current/cancel") { $ok = TRUE; $id = $l->id(); break; }
  }
  print ($ok ? "PASS" : "FAIL") . " id=$id\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
