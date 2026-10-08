#!/usr/bin/env bash
# Introspection SETUP: create a namespaced vocabulary flattax_known and flag it flat via the
# flat_taxonomy third-party setting, so an agent can read back which vocab is flat. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  $v = Vocabulary::load("flattax_known") ?: Vocabulary::create(["vid"=>"flattax_known","name"=>"Flat Known"]);
  $v->setThirdPartySetting("flat_taxonomy","flat",1)->save();
' >/dev/null 2>&1
echo "setup: vocabulary flattax_known has flat_taxonomy.flat=1"
