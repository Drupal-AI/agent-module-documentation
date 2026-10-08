#!/usr/bin/env bash
# Introspection SETUP (no mutation): baseline for "what is the effective media.settings
# standalone_url and who forces it". media_download always overrides it to TRUE at runtime.
set -uo pipefail
cd /var/www/html
eff=$(drush php:eval 'print var_export(\Drupal::config("media.settings")->get("standalone_url"),true);' 2>/dev/null)
stored=$(drush php:eval 'print var_export(\Drupal::configFactory()->getEditable("media.settings")->get("standalone_url"),true);' 2>/dev/null)
echo "setup: stored standalone_url=$stored, effective=$eff (media_download forces effective TRUE)"
