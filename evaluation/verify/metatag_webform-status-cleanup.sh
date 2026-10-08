#!/usr/bin/env bash
# Introspection CLEANUP for the status case. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  use Drupal\metatag\Entity\MetatagDefaults;
  if ($md = MetatagDefaults::load("webform.mtwf_stat")) { $md->delete(); }
  if ($w = Webform::load("mtwf_stat")) { $w->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: webform.mtwf_stat metatags and webform removed"
