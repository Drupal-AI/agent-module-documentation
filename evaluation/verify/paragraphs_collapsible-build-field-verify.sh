#!/usr/bin/env bash
# Execution VERIFY: PASS when a paragraphs reference field field_pgc_build exists on Article and
# its default form widget is the classic entity_reference_paragraphs widget. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node","article","field_pgc_build");
  if (!$fc) { print "FAIL no-field\n"; return; }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_pgc_build") : NULL;
  $type = $c["type"] ?? "none";
  $ok = ($type === "entity_reference_paragraphs");
  print ($ok ? "PASS" : "FAIL") . " field=yes widget=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
