#!/usr/bin/env bash
# Execution RESET (sdc_display): clear any sdc_display view-mode mapping on the Article default
# view display so verify FAILS until the agent enables one. Config-only. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  foreach (["enabled","component","mappings"] as $k) { $vd->unsetThirdPartySetting("sdc_display", $k); }
  $vd->save();
' >/dev/null 2>&1 || true
echo "reset: no sdc_display view-mode mapping on node.article view display"
exit 0
