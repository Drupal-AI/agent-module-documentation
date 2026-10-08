#!/usr/bin/env bash
# Introspection SETUP: put fpa.settings into a KNOWN state — disable the "Module listing"
# and "Role filter" sections (disabled_sections = {modules, roles}), mirroring exactly what
# the FPA settings form saves. An inspecting agent can then read this back with
# `drush config:get fpa.settings disabled_sections`. Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("fpa.settings")
    ->set("disabled_sections", ["modules" => "modules", "roles" => "roles"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: fpa.settings disabled_sections = {modules, roles}"
