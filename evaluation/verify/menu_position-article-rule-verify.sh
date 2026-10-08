#!/usr/bin/env bash
# Execution VERIFY for "create a menu position rule mp_task_article that positions Article
# nodes under the Home link of the Main navigation".
# PASS when the menu_position_rule config entity mp_task_article exists, is enabled, targets
# menu_name 'main' with parent 'standard.front_page', and carries a core entity_bundle:node
# condition whose bundles include 'article'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $r = \Drupal::entityTypeManager()->getStorage("menu_position_rule")->load("mp_task_article");
  if (!$r) { print "FAIL rule=missing\n"; return; }
  $conditions = $r->get("conditions") ?: [];
  $bundleCondition = $conditions["entity_bundle:node"] ?? NULL;
  $bundles = array_values($bundleCondition["bundles"] ?? []);
  $ok = ((bool) $r->getEnabled())
    && $r->getMenuName() === "main"
    && $r->getParent() === "standard.front_page"
    && $bundleCondition !== NULL
    && in_array("article", $bundles, TRUE);
  print ($ok ? "PASS" : "FAIL")
    . " enabled=" . var_export((bool) $r->getEnabled(), TRUE)
    . " menu=" . var_export($r->getMenuName(), TRUE)
    . " parent=" . var_export($r->getParent(), TRUE)
    . " conditions=" . implode(",", array_keys($conditions))
    . " bundles=" . implode(",", $bundles) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
