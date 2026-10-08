#!/usr/bin/env bash
# Execution CLEANUP: restore hcaptcha.settings baseline (empty keys, default widget). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("hcaptcha.settings");
  $c->set("site_key", "")->set("secret_key", "")->set("widget.theme", "")
    ->set("widget.size", "")->set("widget.tabindex", 0)->set("widget.max_score", 0.8)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: hcaptcha.settings restored to shipped defaults"
