#!/usr/bin/env bash
# Introspection SETUP: enable a distinctively-named TacJS service so an inspecting agent can
# report which service is switched on in the live config. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("tacjs.settings")->set("services",["tacjs_probe_service"=>["status"=>TRUE]])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: tacjs.settings services.tacjs_probe_service.status=true"
