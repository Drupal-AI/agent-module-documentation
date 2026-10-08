#!/usr/bin/env bash
# Introspection SETUP for the workbench_access "known menu scheme" medium case.
# Saves a KNOWN access_scheme config entity driven by the MENU hierarchy plugin so the
# model can read its configuration back with drush. Idempotent: deletes any prior copy
# first, then recreates it with fixed values the introspection case asserts on:
#   - id/label:        wa_eval_nav / "Eval Navigation"
#   - scheme (plugin): menu   (an AccessControlHierarchy plugin)
#   - scheme_settings: menus => ["main"], bundles => ["page"]
# Deprecation notices from unrelated contrib modules print on stderr; suppressed with 2>/dev/null.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("access_scheme");
  if ($e = $s->load("wa_eval_nav")) { $e->delete(); }
  $s->create([
    "id" => "wa_eval_nav",
    "label" => "Eval Navigation",
    "plural_label" => "Navigation sections",
    "scheme" => "menu",
    "scheme_settings" => ["menus" => ["main"], "bundles" => ["page"]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: access_scheme 'wa_eval_nav' saved (plugin menu, menu main)"
