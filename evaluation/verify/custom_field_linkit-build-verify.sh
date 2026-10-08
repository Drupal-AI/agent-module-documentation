#!/usr/bin/env bash
# VERIFY: PASS when field_cf_lk is a custom field with a 'uri' column AND that column's subfield
# widget on the default form display is linkit_url. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fs=\Drupal\field\Entity\FieldStorageConfig::loadByName("node","field_cf_lk");
  $type=$fs?$fs->getType():"none"; $cols=$fs?($fs->getSetting("columns")??[]):[];
  $uri=NULL; foreach($cols as $n=>$c){ if(($c["type"]??"")==="uri"){ $uri=$n; } }
  $fd=\Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.cf_lk_eval.default");
  $w=($fd && $uri)?($fd->getComponent("field_cf_lk")["settings"]["fields"][$uri]["type"]??"none"):"none";
  $ok=($type==="custom" && $uri!==NULL && $w==="linkit_url");
  print ($ok?"PASS":"FAIL")." field_type=".$type." uri_col=".($uri??"none")." widget=".$w."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q "^PASS" && exit 0 || exit 1
