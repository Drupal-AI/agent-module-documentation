#!/usr/bin/env bash
# Execution VERIFY: PASS when the 'MFC Task Parent' menu link has menu_firstchild first-child
# linking enabled in its link options. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  $links = $storage->loadByProperties(["title" => "MFC Task Parent"]);
  $link = $links ? reset($links) : NULL;
  $enabled = FALSE;
  if ($link) {
    $opts = $link->get("link")->first()->options ?? [];
    $enabled = !empty($opts["menu_firstchild"]["enabled"]);
  }
  print ($enabled ? "PASS" : "FAIL") . " exists=" . var_export((bool) $link, TRUE) . " enabled=" . var_export($enabled, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
