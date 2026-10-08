#!/usr/bin/env bash
# Live-state verification for the "yearonly founded-year field on Article" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Four independent checks against real site config:
#   fld  — node.article has a field field_eval_year
#   typ  — that field AND its storage are of type `yearonly`
#   from — field setting yearonly_from == 1900
#   to   — field setting yearonly_to resolves to the current year (numeric current year OR "now")
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $fld = FALSE; $typ = FALSE; $from = FALSE; $to = FALSE; $detail = "";
  if ($fc = \Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_eval_year")) {
    $fld = TRUE;
    $fcType = (string) $fc->getType();
    $fsType = "";
    if ($fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_eval_year")) {
      $fsType = (string) $fs->getType();
    }
    if ($fcType === "yearonly" && $fsType === "yearonly") { $typ = TRUE; }
    $vFrom = (string) $fc->getSetting("yearonly_from");
    $vTo = (string) $fc->getSetting("yearonly_to");
    if ((string) (int) $vFrom === "1900") { $from = TRUE; }
    $nowYear = date("Y");
    if ($vTo === "now" || (string) (int) $vTo === $nowYear) { $to = TRUE; }
    $detail = "fc_type=" . $fcType . " fs_type=" . $fsType . " from=" . $vFrom . " to=" . $vTo;
  }
  $ok = $fld && $typ && $from && $to;
  print ($ok ? "PASS" : "FAIL") . " fld=" . ($fld?1:0) . " typ=" . ($typ?1:0) . " from=" . ($from?1:0) . " to=" . ($to?1:0) . " " . $detail . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
