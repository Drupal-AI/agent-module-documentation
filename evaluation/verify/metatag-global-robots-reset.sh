#!/usr/bin/env bash
# Reset for the "global robots + canonical_url defaults" execution task. The metatag_defaults
# `global` config entity always exists; we do NOT delete it — we only reset the two tag keys
# this test touches:
#   - robots        -> removed (baseline global ships with no robots default)
#   - canonical_url -> Metatag's shipped default ([current-page:url])
# Leaves title/description (owned by the other global execution case) untouched. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cfg = \Drupal::configFactory()->getEditable("metatag.metatag_defaults.global");
  $tags = $cfg->get("tags") ?: [];
  unset($tags["robots"]);
  $tags["canonical_url"] = "[current-page:url]";
  $cfg->set("tags", $tags)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: metatag global robots/canonical_url restored to baseline"
