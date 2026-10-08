#!/usr/bin/env bash
# Introspection SETUP (sdc_display): enable an SDC Display view-mode mapping on the Article
# default view display, pointing at a known component (olivero:teaser). Config-only. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setThirdPartySetting("sdc_display", "enabled", TRUE);
  $vd->setThirdPartySetting("sdc_display", "component", ["machine_name" => "olivero:teaser"]);
  $vd->setThirdPartySetting("sdc_display", "mappings", ["static" => ["props" => [], "slots" => []], "dynamic" => ["props" => [], "slots" => []]]);
  $vd->save();
' >/dev/null 2>&1 || true
echo "setup: node.article default view display has sdc_display enabled -> component olivero:teaser"
exit 0
