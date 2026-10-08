#!/usr/bin/env bash
# Execution RESET: ensure webform mtwf_title exists with NO metatag defaults. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  use Drupal\metatag\Entity\MetatagDefaults;
  if (!Webform::load("mtwf_title")) { Webform::create(["id" => "mtwf_title", "title" => "MTWF Title"])->save(); }
  if ($md = MetatagDefaults::load("webform.mtwf_title")) { $md->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: webform mtwf_title present, no metatags"
