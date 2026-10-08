#!/usr/bin/env bash
# Introspection SETUP: seed defaults.node.page.update.anonymous = fmc_editor. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("form_mode_control.settings");
  $d = $c->get("defaults") ?: [];
  $d["node"]["page"]["update"]["anonymous"] = "fmc_editor";
  $c->set("defaults", $d)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: form_mode_control.settings defaults.node.page.update.anonymous=fmc_editor"
