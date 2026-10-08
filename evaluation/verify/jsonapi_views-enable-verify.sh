#!/usr/bin/env bash
# Execution VERIFY: PASS when the jav_task2 default display is exposed via JSON:API — i.e. the
# jsonapi_views extender enabled is TRUE (or the extender was removed, which defaults to TRUE).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("jav_task2");
  $present = FALSE; $en = NULL;
  if ($v) {
    $d = $v->getDisplay("default");
    if (isset($d["display_options"]["display_extenders"]["jsonapi_views"]["enabled"])) {
      $present = TRUE; $en = $d["display_options"]["display_extenders"]["jsonapi_views"]["enabled"];
    }
  }
  // Exposed = extender absent (default TRUE) OR enabled truthy.
  $ok = $v && ((!$present) || !empty($en));
  print ($ok ? "PASS" : "FAIL") . " present=" . var_export($present, TRUE) . " enabled=" . var_export($en, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
