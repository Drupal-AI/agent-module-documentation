#!/usr/bin/env bash
# Execution CLEANUP for the title case. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  use Drupal\metatag\Entity\MetatagDefaults;
  if ($md = MetatagDefaults::load("webform.mtwf_title")) { $md->delete(); }
  if ($w = Webform::load("mtwf_title")) { $w->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: webform.mtwf_title metatags and webform removed"
