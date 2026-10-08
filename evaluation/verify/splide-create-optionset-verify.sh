#!/usr/bin/env bash
# Execution VERIFY: PASS when splide.optionset.spl_task exists with options.settings.type=='loop' and
# perPage==3. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\splide\Entity\Splide;
  $e = Splide::load("spl_task");
  $c = \Drupal::config("splide.optionset.spl_task");
  $type = $c->get("options.settings.type");
  $pp = $c->get("options.settings.perPage");
  $ok = ($e && $type==="loop" && (int)$pp===3);
  print ($ok?"PASS":"FAIL")." exists=".($e?"yes":"no")." type=".var_export($type,TRUE)." perPage=".var_export($pp,TRUE);
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
