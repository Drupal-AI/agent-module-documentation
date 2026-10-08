#!/usr/bin/env bash
# Introspection SETUP: write a KNOWN global default meta description to the live site so an
# inspecting agent can read it back with drush. Only touches the `description` tag key of the
# shipped metatag_defaults `global` config entity (never deletes the entity). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cfg = \Drupal::configFactory()->getEditable("metatag.metatag_defaults.global");
  $tags = $cfg->get("tags") ?: [];
  $tags["description"] = "Eval baseline meta description for the whole site.";
  $cfg->set("tags", $tags)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: metatag global default description set to known eval string"
