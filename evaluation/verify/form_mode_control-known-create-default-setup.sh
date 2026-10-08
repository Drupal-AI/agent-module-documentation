#!/usr/bin/env bash
# Introspection SETUP: seed a known Form Mode Control default so an inspecting agent can read it.
# defaults.node.article.create.anonymous = fmc_compact in form_mode_control.settings. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("form_mode_control.settings");
  $d = $c->get("defaults") ?: [];
  $d["node"]["article"]["create"]["anonymous"] = "fmc_compact";
  $c->set("defaults", $d)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: form_mode_control.settings defaults.node.article.create.anonymous=fmc_compact"
