#!/usr/bin/env bash
# Execution RESET: ensure vocabulary flattax_task exists and is NOT flat (verify FAILS until the
# agent flags it flat). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  $v = Vocabulary::load("flattax_task") ?: Vocabulary::create(["vid"=>"flattax_task","name"=>"Flat Task"]);
  $v->unsetThirdPartySetting("flat_taxonomy","flat");
  $v->save();
' >/dev/null 2>&1
echo "reset: vocabulary flattax_task present, not flat"
