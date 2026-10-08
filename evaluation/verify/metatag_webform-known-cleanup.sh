#!/usr/bin/env bash
# Introspection CLEANUP: remove the metatag defaults and webform created by setup. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  use Drupal\metatag\Entity\MetatagDefaults;
  if ($md = MetatagDefaults::load("webform.mtwf_known")) { $md->delete(); }
  if ($w = Webform::load("mtwf_known")) { $w->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: webform.mtwf_known metatags and webform removed"
