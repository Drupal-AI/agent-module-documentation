#!/usr/bin/env bash
# Introspection SETUP: create a webform (mtwf_stat) whose webform.mtwf_stat metatag defaults
# entity is DISABLED (status false), so an agent can report whether its metatags are active.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  use Drupal\metatag\Entity\MetatagDefaults;
  if (!Webform::load("mtwf_stat")) { Webform::create(["id" => "mtwf_stat", "title" => "MTWF Stat"])->save(); }
  $md = MetatagDefaults::load("webform.mtwf_stat") ?? MetatagDefaults::create(["id" => "webform.mtwf_stat", "label" => "Webform: MTWF Stat"]);
  $md->set("tags", ["description" => "Disabled metatags."]);
  $md->setStatus(FALSE);
  $md->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: metatag.metatag_defaults.webform.mtwf_stat status=false"
