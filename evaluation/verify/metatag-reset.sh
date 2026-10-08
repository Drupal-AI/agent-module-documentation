#!/usr/bin/env bash
# Reset the Metatag global defaults to a clean, known baseline between eval runs so
# each condition is independent. The metatag_defaults `global` config entity always
# exists; we do NOT delete it — we only reset the two tag keys this test touches:
#   - title       -> Metatag's shipped default ([current-page:title] | [site:name])
#   - description  -> removed (baseline global ships with no description)
# Then rebuild caches so the change is live.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cfg = \Drupal::configFactory()->getEditable("metatag.metatag_defaults.global");
  $tags = $cfg->get("tags") ?: [];
  $tags["title"] = "[current-page:title] | [site:name]";
  unset($tags["description"]);
  $cfg->set("tags", $tags)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: metatag global defaults title/description restored to baseline"
