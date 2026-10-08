#!/usr/bin/env bash
# Introspection SETUP: customise the site-wide layout catalogue — rename the md breakpoint and
# add a 20% / 80% two-column layout to it — so the agent must read ckeditor_bs_grid.settings on
# the live site rather than recite the module defaults. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $config = \Drupal::configFactory()->getEditable("ckeditor_bs_grid.settings");
  $bp = $config->get("breakpoints");
  $bp["md"]["label"] = "Tablet (md)";
  $bp["md"]["columns"][2]["layouts"]["option_9"] = [
    "label" => "20% / 80%",
    "settings" => ["col-1" => "2", "col-2" => "10"],
  ];
  $config->set("breakpoints", $bp)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
drush php:eval '
  $bp = \Drupal::config("ckeditor_bs_grid.settings")->get("breakpoints");
  $labels = array_column($bp["md"]["columns"][2]["layouts"], "label");
  print "setup: md label=" . $bp["md"]["label"] . " 2col layouts=" . implode(", ", $labels) . "\n";
' 2>/dev/null
exit 0
