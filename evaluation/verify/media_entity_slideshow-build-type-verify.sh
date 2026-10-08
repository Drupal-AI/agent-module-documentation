#!/usr/bin/env bash
# Execution VERIFY: PASS when media type mes_task exists, uses the slideshow source, and has a
# configured entity_reference source field that exists. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldConfig;
  $t = MediaType::load("mes_task");
  if (!$t) { print "FAIL no-type\n"; return; }
  $src = $t->getSource()->getPluginId();
  $sf = $t->getSource()->getSourceFieldDefinition($t);
  $sf_name = $sf ? $sf->getName() : ($t->get("source_configuration")["source_field"] ?? "");
  $field_exists = $sf_name && FieldConfig::loadByName("media","mes_task",$sf_name);
  $ok = ($src === "slideshow") && $sf_name && $field_exists;
  print ($ok ? "PASS" : "FAIL") . " source=" . $src . " source_field=" . $sf_name . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
