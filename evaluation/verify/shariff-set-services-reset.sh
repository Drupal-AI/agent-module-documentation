#!/usr/bin/env bash
# Execution RESET: set shariff.settings back to shipped defaults (services twitter,facebook;
# theme colored) so verify FAILS until the agent adds linkedin+mail and sets theme white.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("shariff.settings")
    ->set("shariff_services", ["twitter"=>"twitter","facebook"=>"facebook"])
    ->set("shariff_theme", "colored")
    ->set("shariff_css", "complete")
    ->set("shariff_orientation", "horizontal")
    ->clear("shariff_button_style")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: shariff.settings restored to shipped defaults (twitter,facebook / colored)"
