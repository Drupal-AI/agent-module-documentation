#!/usr/bin/env bash
# Live-state verification for the "yearonly vintage field on Basic page" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Four independent checks against real site config:
#   fld  — node.page has a field field_eval_vintage
#   typ  — that field AND its storage are of type `yearonly`
#   from — field setting yearonly_from == 1800
#   to   — field setting yearonly_to == 2000
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $fld = FALSE; $typ = FALSE; $from = FALSE; $to = FALSE; $detail = "";
  if ($fc = \Drupal\field\Entity\FieldConfig::loadByName("node", "page", "field_eval_vintage")) {
    $fld = TRUE;
    $fcType = (string) $fc->getType();
    $fsType = "";
    if ($fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_eval_vintage")) {
      $fsType = (string) $fs->getType();
    }
    if ($fcType === "yearonly" && $fsType === "yearonly") { $typ = TRUE; }
    $vFrom = (string) $fc->getSetting("yearonly_from");
    $vTo = (string) $fc->getSetting("yearonly_to");
    if ((string) (int) $vFrom === "1800") { $from = TRUE; }
    if ((string) (int) $vTo === "2000") { $to = TRUE; }
    $detail = "fc_type=" . $fcType . " fs_type=" . $fsType . " from=" . $vFrom . " to=" . $vTo;
  }
  $ok = $fld && $typ && $from && $to;
  print ($ok ? "PASS" : "FAIL") . " fld=" . ($fld?1:0) . " typ=" . ($typ?1:0) . " from=" . ($from?1:0) . " to=" . ($to?1:0) . " " . $detail . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
