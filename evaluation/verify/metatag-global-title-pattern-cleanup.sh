#!/usr/bin/env bash
# Introspection CLEANUP: restore the metatag_defaults `global` entity `title` tag to Metatag's
# shipped baseline default ([current-page:title] | [site:name]). Never deletes the entity.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cfg = \Drupal::configFactory()->getEditable("metatag.metatag_defaults.global");
  $tags = $cfg->get("tags") ?: [];
  $tags["title"] = "[current-page:title] | [site:name]";
  $cfg->set("tags", $tags)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: metatag global default title pattern restored to baseline"
