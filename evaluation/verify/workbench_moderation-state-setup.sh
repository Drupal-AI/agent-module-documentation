#!/usr/bin/env bash
# Introspection SETUP: create a custom moderation state 'wbm_eval_legal' (unpublished). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\workbench_moderation\Entity\ModerationState;
  if (!ModerationState::load("wbm_eval_legal")) {
    ModerationState::create(["id"=>"wbm_eval_legal","label"=>"Legal Review","published"=>FALSE,"default_revision"=>FALSE])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: moderation_state wbm_eval_legal (Legal Review, published=false) created"
