#!/usr/bin/env bash
# Introspection SETUP: write a known namespaced config config_distro_eval.data to the ACTIVE
# storage so the agent can read it back through the config_distro.storage.distro service (which
# mirrors active config, as transformed by subscribers) and report a value. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("config_distro_eval.data")->setData(["color" => "teal", "n" => 7])->save();' >/dev/null 2>&1
echo "setup: active config config_distro_eval.data = {color: teal, n: 7}"
