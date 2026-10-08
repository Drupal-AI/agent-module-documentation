#!/usr/bin/env bash
# Introspection SETUP: create a namespaced webform (mtwf_known) and a metatag_defaults entity
# webform.mtwf_known carrying a known title tag, so an inspecting agent can read it back.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  use Drupal\metatag\Entity\MetatagDefaults;
  if (!Webform::load("mtwf_known")) { Webform::create(["id" => "mtwf_known", "title" => "MTWF Known"])->save(); }
  $md = MetatagDefaults::load("webform.mtwf_known") ?? MetatagDefaults::create(["id" => "webform.mtwf_known", "label" => "Webform: MTWF Known"]);
  $md->set("tags", ["title" => "Contact Acme Support", "description" => "Reach the Acme support team."]);
  $md->setStatus(TRUE);
  $md->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: metatag.metatag_defaults.webform.mtwf_known title='Contact Acme Support'"
