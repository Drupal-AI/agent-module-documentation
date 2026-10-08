#!/usr/bin/env bash
# Execution VERIFY: PASS when view vft_task2 uses flipped_table AND its
# flipped_table_header_first_field option is falsey (turned off). Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v=View::load("vft_task2");
  $ok=FALSE; $type="no-view"; $opt="n/a";
  if ($v) {
    $s=$v->getDisplay("default")["display_options"]["style"];
    $type=$s["type"] ?? "none";
    $opt=var_export($s["options"]["flipped_table_header_first_field"] ?? null, TRUE);
    $ok = ($type==="flipped_table" && empty($s["options"]["flipped_table_header_first_field"]));
  }
  print (($ok)?"PASS":"FAIL")." style=$type header_first=$opt\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
