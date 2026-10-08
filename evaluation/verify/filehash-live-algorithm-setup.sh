#!/usr/bin/env bash
# Introspection SETUP: enable the SHA-256 algorithm in filehash.settings (fires the config
# subscriber that adds the file_managed.sha256 column) so an inspecting agent can read which
# algorithm is enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("filehash.settings");
  $a = $c->get("algorithms"); $a["sha256"] = TRUE; $c->set("algorithms", $a)->save();
' >/dev/null 2>&1
echo "setup: filehash.settings algorithms.sha256=true"
