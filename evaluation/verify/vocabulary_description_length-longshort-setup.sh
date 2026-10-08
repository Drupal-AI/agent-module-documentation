#!/usr/bin/env bash
# Introspection SETUP: create two vocabularies, vdl_long (long description) and vdl_short
# (one-line description). Raw config writes. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $f = \Drupal::configFactory();
  $f->getEditable("taxonomy.vocabulary.vdl_long")->setData([
    "langcode"=>"en","status"=>true,"dependencies"=>[],"name"=>"VDL Long","vid"=>"vdl_long",
    "weight"=>0,"new_revision"=>false,"description"=>"Governance policy for editorial tags. This vocabulary groups content by topic and audience. Editors MUST follow the naming convention documented here, keep terms lowercase, and avoid creating near-duplicate terms. New terms require review by the content team before publication. See the editorial handbook for the full multi-paragraph rationale and examples.","uuid"=>\Drupal::service("uuid")->generate(),
  ])->save();
  $f->getEditable("taxonomy.vocabulary.vdl_short")->setData([
    "langcode"=>"en","status"=>true,"dependencies"=>[],"name"=>"VDL Short","vid"=>"vdl_short",
    "weight"=>0,"new_revision"=>false,"description"=>"Short one-liner.","uuid"=>\Drupal::service("uuid")->generate(),
  ])->save();
' >/dev/null 2>&1
echo "setup: vdl_long (long desc) and vdl_short (short desc) created"
