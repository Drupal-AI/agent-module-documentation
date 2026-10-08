#!/usr/bin/env bash
# Introspection SETUP: put mathjax.settings into a known non-default state - Custom
# configuration mode (config_type 1), a distinctive local/pinned CDN URL, admin pages enabled,
# and a custom JSON config string - so an inspecting agent must read the live config.
# The previous values are saved to state so the cleanup can restore them exactly. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("mathjax.settings");
  \Drupal::state()->set("mathjax_eval.backup", $c->getRawData());
  $c->set("use_cdn", 1)
    ->set("cdn_url", "https://cdn.jsdelivr.net/npm/mathjax@2.7.9/MathJax.js?config=TeX-MML-AM_CHTML")
    ->set("config_type", 1)
    ->set("config_string", "{\"tex2jax\":{\"inlineMath\":[[\"@@\",\"@@\"]]},\"messageStyle\":\"none\"}")
    ->set("enable_for_admin", 1)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: mathjax.settings config_type=1 enable_for_admin=1 cdn_url=jsdelivr mathjax@2.7.9"
