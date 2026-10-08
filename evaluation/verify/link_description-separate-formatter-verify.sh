#!/usr/bin/env bash
# Execution VERIFY: PASS when the link_description field field_ld_disp still exists on Article AND
# its node.article.default view display renders it with the link_separate_description formatter.
# (Requiring the field to exist guards against a stale display component.) exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node", "article", "field_ld_disp");
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_ld_disp") : NULL;
  $ok = $fc && $c && ($c["type"] ?? "") === "link_separate_description";
  print ($ok ? "PASS" : "FAIL") . " field=" . var_export((bool) $fc, TRUE) . " formatter=" . ($c["type"] ?? "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
