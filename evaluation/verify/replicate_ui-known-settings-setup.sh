#!/usr/bin/env bash
# Introspection SETUP for the replicate_ui "known settings" medium cases.
# Saves a KNOWN replicate_ui.settings config to the live site so the model can be asked
# to read it (and the routes/tabs it produces) back with drush. Idempotent: it simply
# overwrites the two keys the cases assert on with fixed, distinctive values:
#   - entity_types:      ["node", "taxonomy_term"]  (Replicate UI enabled for these)
#   - check_edit_access: true                        (also require edit access on original)
# A cache/route rebuild is run so the derived entity.{type}.replicate routes exist (the
# settings form does this automatically; a direct config write must do it explicitly).
# Deprecation notices from unrelated contrib modules print on stdout, so they are
# discarded and only the human-readable result line is echoed.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("replicate_ui.settings")
    ->set("entity_types", ["node", "taxonomy_term"])
    ->set("check_edit_access", TRUE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: replicate_ui.settings saved (entity_types=[node,taxonomy_term], check_edit_access=true)"
