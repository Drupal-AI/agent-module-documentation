#!/usr/bin/env bash
# Introspection SETUP: write a KNOWN global default title tag token pattern to the live site so
# an inspecting agent can read it back with drush. Only touches the `title` tag key of the
# shipped metatag_defaults `global` config entity (never deletes the entity). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cfg = \Drupal::configFactory()->getEditable("metatag.metatag_defaults.global");
  $tags = $cfg->get("tags") ?: [];
  $tags["title"] = "[current-page:title] | [site:name] | Eval Site";
  $cfg->set("tags", $tags)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: metatag global default title pattern set to known eval token pattern"
