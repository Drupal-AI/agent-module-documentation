#!/usr/bin/env bash
# Execution VERIFY: PASS when the 'SMI Task Link' menu link has a non-empty simple_menu_icons
# icon configured in its link options (menu_icon with a uri or fid). Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  $ids = $s->getQuery()->accessCheck(FALSE)->condition("title","SMI Task Link")->execute();
  $ok = FALSE; $detail = "no-link";
  if ($ids) {
    $link = $s->load(reset($ids));
    $opts = $link->link->first()->options ?? [];
    $icon = $opts["menu_icon"] ?? NULL;
    $has = is_array($icon) && ((!empty($icon["uri"])) || (!empty($icon["fid"])));
    $ok = (bool) $has;
    $detail = "menu_icon=" . json_encode($icon);
  }
  print ($ok ? "PASS" : "FAIL") . " " . $detail . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
