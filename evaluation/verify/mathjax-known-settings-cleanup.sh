#!/usr/bin/env bash
# Introspection CLEANUP: restore the exact mathjax.settings data saved by the matching setup
# (falling back to the module's shipped defaults if no backup exists). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $backup = \Drupal::state()->get("mathjax_eval.backup");
  $c = \Drupal::configFactory()->getEditable("mathjax.settings");
  if (is_array($backup) && $backup) {
    unset($backup["_core"]);
    foreach (["use_cdn", "cdn_url", "config_type", "default_config_string", "config_string", "enable_for_admin"] as $k) {
      if (array_key_exists($k, $backup)) { $c->set($k, $backup[$k]); }
      else { $c->clear($k); }
    }
    $c->save();
  }
  else {
    $c->set("use_cdn", 1)
      ->set("cdn_url", "https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/MathJax.js?config=TeX-AMS-MML_HTMLorMML")
      ->set("config_type", 0)
      ->set("enable_for_admin", 0)
      ->clear("config_string")
      ->save();
  }
  \Drupal::state()->delete("mathjax_eval.backup");
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: mathjax.settings restored"
