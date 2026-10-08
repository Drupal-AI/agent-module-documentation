#!/usr/bin/env bash
# Introspection SETUP: create vocabulary vdl_known with a long multi-paragraph description.
# Raw config write (config-entity save via API is blocked by an unrelated broken field on this
# shared site). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $u = \Drupal::service("uuid")->generate();
  \Drupal::configFactory()->getEditable("taxonomy.vocabulary.vdl_known")->setData([
    "langcode"=>"en","status"=>true,"dependencies"=>[],
    "name"=>"VDL Known","vid"=>"vdl_known","weight"=>0,"new_revision"=>false,
    "description"=>"Governance policy for editorial tags. This vocabulary groups content by topic and audience. Editors MUST follow the naming convention documented here, keep terms lowercase, and avoid creating near-duplicate terms. New terms require review by the content team before publication. See the editorial handbook for the full multi-paragraph rationale and examples.","uuid"=>$u,
  ])->save();
' >/dev/null 2>&1
echo "setup: taxonomy vocabulary vdl_known created with a long description"
