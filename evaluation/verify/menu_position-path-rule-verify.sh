#!/usr/bin/env bash
# Execution VERIFY for "create a path-based menu position rule mp_task_docs for /docs and
# /docs/* in the main menu, and make matches insert the current page into the menu tree".
# PASS when the mp_task_docs rule exists, is enabled, targets menu 'main' with parent
# 'standard.front_page', carries a core request_path condition listing /docs and /docs/*, and
# menu_position.settings:link_display is 'child'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $r = \Drupal::entityTypeManager()->getStorage("menu_position_rule")->load("mp_task_docs");
  $display = \Drupal::config("menu_position.settings")->get("link_display");
  if (!$r) { print "FAIL rule=missing link_display=" . var_export($display, TRUE) . "\n"; return; }
  $conditions = $r->get("conditions") ?: [];
  $pages = $conditions["request_path"]["pages"] ?? "";
  $ok = ((bool) $r->getEnabled())
    && $r->getMenuName() === "main"
    && $r->getParent() === "standard.front_page"
    && isset($conditions["request_path"])
    && (bool) preg_match("#(^|\s)/docs(\s|$)#", $pages)
    && str_contains($pages, "/docs/*")
    && $display === "child";
  print ($ok ? "PASS" : "FAIL")
    . " enabled=" . var_export((bool) $r->getEnabled(), TRUE)
    . " menu=" . var_export($r->getMenuName(), TRUE)
    . " parent=" . var_export($r->getParent(), TRUE)
    . " conditions=" . implode(",", array_keys($conditions))
    . " pages=" . json_encode($pages)
    . " link_display=" . var_export($display, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
