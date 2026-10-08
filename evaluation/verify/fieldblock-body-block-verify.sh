#!/usr/bin/env bash
# Execution VERIFY: PASS when block fieldblock_task_body exists in the Olivero theme's
# sidebar region, uses the fieldblock:node plugin, renders the body field with the
# text_default formatter and takes its title from the field label (label_from_field TRUE).
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("fieldblock_task_body");
  $s = $b ? $b->get("settings") : [];
  $ok = $b
    && $b->get("plugin") === "fieldblock:node"
    && $b->getTheme() === "olivero"
    && $b->getRegion() === "sidebar"
    && ($s["field_name"] ?? NULL) === "body"
    && ($s["formatter_id"] ?? NULL) === "text_default"
    && !empty($s["label_from_field"]);
  print ($ok ? "PASS" : "FAIL")
    . " plugin=" . ($b ? $b->get("plugin") : "none")
    . " theme=" . ($b ? $b->getTheme() : "none")
    . " region=" . ($b ? $b->getRegion() : "none")
    . " field=" . ($s["field_name"] ?? "none")
    . " formatter=" . ($s["formatter_id"] ?? "none")
    . " label_from_field=" . var_export($s["label_from_field"] ?? NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
