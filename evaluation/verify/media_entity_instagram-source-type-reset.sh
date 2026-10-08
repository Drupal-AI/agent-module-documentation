#!/usr/bin/env bash
# Reset the "create an Instagram-backed media type" execution task to a clean slate.
# Removes what the task creates: the `ig_eval` media type and its source field
# (config + storage). No precondition create is needed (the task builds everything).
# Idempotent (deletes are guarded). Rebuilds caches. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  if ($t = MediaType::load("ig_eval")) { $t->delete(); }
  if ($fc = \Drupal\field\Entity\FieldConfig::loadByName("media", "ig_eval", "field_media_oembed_instagram")) { $fc->delete(); }
  // Only drop the shared source-field storage if no other media type still uses it.
  $inUse = FALSE;
  foreach (\Drupal\field\Entity\FieldConfig::loadMultiple() as $cfg) {
    if ($cfg->getName() === "field_media_oembed_instagram") { $inUse = TRUE; break; }
  }
  if (!$inUse && $fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("media", "field_media_oembed_instagram")) {
    try { $fs->delete(); } catch (\Exception $e) {}
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: media type ig_eval removed"
