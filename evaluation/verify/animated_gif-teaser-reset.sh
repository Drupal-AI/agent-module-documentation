#!/usr/bin/env bash
# Execution RESET: remove image field field_ag_hero (and thus its teaser component) so verify FAILS
# until the agent creates the field and sets the animated_gif_image_url formatter on the teaser
# view display.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_ag_hero")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_ag_hero")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_ag_hero removed"
