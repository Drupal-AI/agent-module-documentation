#!/usr/bin/env bash
# PASS when block blocache_tagtask has a blocache override (overridden true) whose tags include node_list.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("blocache_tagtask");
  $ov = $b ? $b->getThirdPartySetting("blocache","overridden") : NULL;
  $md = $b ? $b->getThirdPartySetting("blocache","metadata") : NULL;
  $tags = (is_array($md) && isset($md["tags"]) && is_array($md["tags"])) ? $md["tags"] : [];
  $ok = ($ov === TRUE) && in_array("node_list", $tags, TRUE);
  print ($ok ? "PASS" : "FAIL")." overridden=".var_export($ov,TRUE)." tags=".implode(",",$tags)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
