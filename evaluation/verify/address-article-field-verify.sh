#!/usr/bin/env bash
# Live-state verification for the "field_eval_address on Article" address task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Two independent checks against real site config:
#   fld — node.article has a field field_eval_address
#   typ — that field (and its storage) is of type `address`
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $fld = FALSE; $typ = FALSE; $detail = "";
  if ($fc = \Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_eval_address")) {
    $fld = TRUE;
    $fcType = (string) $fc->getType();
    $fsType = "";
    if ($fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_eval_address")) {
      $fsType = (string) $fs->getType();
    }
    if ($fcType === "address" && $fsType === "address") { $typ = TRUE; }
    $detail = "fc_type=" . $fcType . " fs_type=" . $fsType;
  }
  $ok = $fld && $typ;
  print ($ok ? "PASS" : "FAIL") . " fld=" . ($fld?1:0) . " typ=" . ($typ?1:0) . " " . $detail . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
