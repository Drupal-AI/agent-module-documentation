#!/usr/bin/env bash
# Execution CLEANUP: restore mathjax.settings to the shipped defaults (CDN on, Text Format
# mode, admin pages off) after the execution case has run.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("mathjax.settings")
    ->set("use_cdn", 1)
    ->set("cdn_url", "https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/MathJax.js?config=TeX-AMS-MML_HTMLorMML")
    ->set("config_type", 0)
    ->set("enable_for_admin", 0)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: mathjax.settings restored to defaults"
