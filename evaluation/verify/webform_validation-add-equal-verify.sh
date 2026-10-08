#!/usr/bin/env bash
# Execution VERIFY for "make wfv_confirm require equal value to wfv_email on webform wfv_task".
# PASS when wfv_confirm has #equal__enabled truthy AND #equal__components includes wfv_email.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\webform\Entity\Webform;
  $w = Webform::load("wfv_task");
  $el = $w ? $w->getElementDecoded("wfv_confirm") : NULL;
  $on = !empty($el["#equal__enabled"]);
  $comp = $el["#equal__components"] ?? [];
  $hit = in_array("wfv_email", array_values($comp), TRUE) || array_key_exists("wfv_email", $comp);
  $ok = ($on && $hit);
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($on, TRUE) . " components=" . json_encode($comp) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
