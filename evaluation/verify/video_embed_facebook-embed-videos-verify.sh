#!/usr/bin/env bash
# Execution VERIFY (video_embed_facebook): PASS when a video_embed_field field field_vef_task exists
# on Article and a node 'vef_task' stores a Facebook video URL (matching the facebook provider's URL
# pattern). Reads the raw stored value only (does NOT load the Facebook provider class, which would
# fatal on this VEF version). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  $fs = FieldStorageConfig::loadByName("node","field_vef_task");
  $type = $fs ? $fs->getType() : "none";
  $val = "";
  foreach(\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title"=>"vef_task"]) as $n){
    if ($n->hasField("field_vef_task")) { $val = (string) $n->get("field_vef_task")->value; }
  }
  $pat = "#^https?://(www\\.)?facebook\\.com/.+(videos/|video\\.php).*[0-9]#";
  $ok = ($type === "video_embed_field") && preg_match($pat, $val);
  print ($ok?"PASS":"FAIL")." type=".$type." value=[".$val."]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
