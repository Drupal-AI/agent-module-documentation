#!/usr/bin/env bash
# Execution CLEANUP: remove the webform and its metatags built during the exec case. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  use Drupal\metatag\Entity\MetatagDefaults;
  if ($md = MetatagDefaults::load("webform.mtwf_task")) { $md->delete(); }
  if ($w = Webform::load("mtwf_task")) { $w->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: webform.mtwf_task metatags and webform removed"
