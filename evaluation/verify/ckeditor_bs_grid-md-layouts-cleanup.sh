#!/usr/bin/env bash
# Introspection CLEANUP: restore ckeditor_bs_grid.settings:breakpoints from the module's own
# config/install file, i.e. back to the shipped catalogue. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Component\Serialization\Yaml;
  $file = "/var/www/html/web/modules/contrib/ckeditor_bs_grid/config/install/ckeditor_bs_grid.settings.yml";
  $defaults = Yaml::decode(file_get_contents($file));
  \Drupal::configFactory()->getEditable("ckeditor_bs_grid.settings")
    ->set("breakpoints", $defaults["breakpoints"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
drush php:eval '
  $bp = \Drupal::config("ckeditor_bs_grid.settings")->get("breakpoints");
  print "cleanup: md label=" . $bp["md"]["label"] . " 2col layout count=" . count($bp["md"]["columns"][2]["layouts"]) . "\n";
' 2>/dev/null
exit 0
