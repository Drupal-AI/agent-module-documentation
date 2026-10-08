#!/usr/bin/env bash
# MEDIUM introspection setup: exclude a known set of roles from SearchStax analytics tracking
# so the agent can read the untracked_roles list back from live config. Restored by -cleanup.
# No SearchStax network access required — this only touches the searchstax.settings config.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("searchstax.settings")
    ->set("untracked_roles", ["administrator", "editor"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: searchstax untracked_roles=[administrator, editor]"
