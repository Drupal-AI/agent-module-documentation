#!/usr/bin/env bash
# Execution VERIFY: PASS when media type "mi_task" exists, its media source is inline_frame,
# and its configured source field is an "iframe"-type field. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\media\Entity\MediaType;
  $t=MediaType::load("mi_task");
  $ok=FALSE; $src="none"; $ftype="none";
  if ($t) {
    $src=$t->getSource()->getPluginId();
    $sf=$t->getSource()->getConfiguration()["source_field"] ?? "";
    if ($sf) {
      $defs=\Drupal::service("entity_field.manager")->getFieldDefinitions("media","mi_task");
      $ftype=isset($defs[$sf]) ? $defs[$sf]->getType() : "missing";
    }
    $ok=($src==="inline_frame" && $ftype==="iframe");
  }
  print ($ok?"PASS":"FAIL")." source=$src field_type=$ftype\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
