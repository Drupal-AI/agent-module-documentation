#!/usr/bin/env bash
# Execution VERIFY: PASS when the taxonomy_machine_name_hierarchy processor on satmn_index has
# hierarchy indexing ENABLED (status TRUE) for field_satmn_cat_machine_name. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $i=\Drupal\search_api\Entity\Index::load("satmn_index");
  $ok=FALSE; $val=NULL;
  if ($i && in_array("taxonomy_machine_name_hierarchy", array_keys($i->getProcessors()))) {
    $conf=$i->getProcessor("taxonomy_machine_name_hierarchy")->getConfiguration();
    $val=$conf["fields"]["field_satmn_cat_machine_name"]["status"] ?? NULL;
    $ok=($val===TRUE || $val===1);
  }
  print ($ok?"PASS":"FAIL")." status=".var_export($val,TRUE)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
