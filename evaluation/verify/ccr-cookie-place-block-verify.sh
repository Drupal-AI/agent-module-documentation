#!/usr/bin/env bash
# Execution VERIFY: PASS when block ccr_switcher_task exists, plugin commerce_currency_resolver_cookie,
# region content. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $b=\Drupal\block\Entity\Block::load("ccr_switcher_task");
  if(!$b){print "FAIL missing"; return;}
  $ok=($b->getPluginId()==="commerce_currency_resolver_cookie" && $b->getRegion()==="content");
  print ($ok?"PASS":"FAIL")." plugin=".$b->getPluginId()." region=".$b->getRegion();
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
