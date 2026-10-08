#!/usr/bin/env bash
# Execution VERIFY: PASS when 'SMI Target Link' has its simple_menu_icons icon uri set to
# exactly public://menu_icons/smi_target.svg. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  $ids = $s->getQuery()->accessCheck(FALSE)->condition("title","SMI Target Link")->execute();
  $ok = FALSE; $detail = "no-link";
  if ($ids) {
    $link = $s->load(reset($ids));
    $opts = $link->link->first()->options ?? [];
    $uri = $opts["menu_icon"]["uri"] ?? NULL;
    $ok = ($uri === "public://menu_icons/smi_target.svg");
    $detail = "uri=" . var_export($uri, TRUE);
  }
  print ($ok ? "PASS" : "FAIL") . " " . $detail . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
