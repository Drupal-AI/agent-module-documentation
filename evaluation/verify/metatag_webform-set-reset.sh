#!/usr/bin/env bash
# Execution RESET: ensure webform mtwf_task exists but has NO metatag defaults
# (so verify FAILS until the agent adds them). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  use Drupal\metatag\Entity\MetatagDefaults;
  if (!Webform::load("mtwf_task")) { Webform::create(["id" => "mtwf_task", "title" => "MTWF Task"])->save(); }
  if ($md = MetatagDefaults::load("webform.mtwf_task")) { $md->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: webform mtwf_task present, no webform.mtwf_task metatags"
