#!/usr/bin/env bash
# Execution VERIFY: PASS when node.article has a field 'field_wf_attach' of type 'workflow' whose
# storage setting workflow_type is 'wf_attach'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node","field_wf_attach");
  $fc = FieldConfig::loadByName("node","article","field_wf_attach");
  $type = $fs ? $fs->getType() : NULL;
  $wt = $fs ? ($fs->getSetting("workflow_type")) : NULL;
  $ok = $fs && $fc && ($type === "workflow") && ($wt === "wf_attach");
  print ($ok ? "PASS" : "FAIL") . " storage=" . ($fs?"1":"0") . " field=" . ($fc?"1":"0") . " type=" . var_export($type,TRUE) . " workflow_type=" . var_export($wt,TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
