#!/usr/bin/env bash
# Live-state verification for the "computed_eval_referrers on Article" computed_field task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Three independent checks against real site config:
#   cf  — a computed_field config entity node.article.computed_eval_referrers exists
#   plg — it is supplied by the reverse_entity_reference plugin
#   typ — its resolved core field type is entity_reference
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $cf = FALSE; $plg = FALSE; $typ = FALSE; $detail = "";
  if ($e = \Drupal::entityTypeManager()->getStorage("computed_field")->load("node.article.computed_eval_referrers")) {
    $cf = TRUE;
    $pid = (string) $e->get("plugin_id");
    $ft  = (string) $e->getType();
    $plg = ($pid === "reverse_entity_reference");
    $typ = ($ft === "entity_reference");
    $detail = "plugin_id=" . $pid . " field_type=" . $ft;
  }
  $ok = $cf && $plg && $typ;
  print ($ok ? "PASS" : "FAIL") . " cf=" . ($cf?1:0) . " plg=" . ($plg?1:0) . " typ=" . ($typ?1:0) . " " . $detail . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
