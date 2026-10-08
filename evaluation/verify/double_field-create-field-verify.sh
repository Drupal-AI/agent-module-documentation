#!/usr/bin/env bash
# Execution VERIFY for "create a Double Field field_df_task on Article".
# PASS when:
#   - field storage node.field_df_task exists, type double_field
#   - settings.storage.first.type  == 'string'  with maxlength 64
#   - settings.storage.second.type == 'integer'
#   - the Article instance exists and BOTH subfields are required
#   - the default form display uses the 'double_field' widget
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_df_task");
  $fc = FieldConfig::loadByName("node", "article", "field_df_task");
  $type = $fs ? $fs->getType() : "none";
  $st = $fs ? ($fs->getSetting("storage") ?? []) : [];
  $t1 = $st["first"]["type"] ?? "none";
  $len1 = $st["first"]["maxlength"] ?? NULL;
  $t2 = $st["second"]["type"] ?? "none";
  $r1 = $fc ? ($fc->getSetting("first")["required"] ?? NULL) : NULL;
  $r2 = $fc ? ($fc->getSetting("second")["required"] ?? NULL) : NULL;
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $widget = ($fd && ($c = $fd->getComponent("field_df_task"))) ? ($c["type"] ?? "none") : "none";
  $ok = $fs && $fc && $type === "double_field"
    && $t1 === "string" && (int) $len1 === 64
    && $t2 === "integer"
    && (bool) $r1 === TRUE && (bool) $r2 === TRUE
    && $widget === "double_field";
  print ($ok ? "PASS" : "FAIL")
    . " type=" . $type
    . " first=" . $t1 . "/" . var_export($len1, TRUE)
    . " second=" . $t2
    . " required=" . var_export((bool) $r1, TRUE) . "," . var_export((bool) $r2, TRUE)
    . " widget=" . $widget . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
