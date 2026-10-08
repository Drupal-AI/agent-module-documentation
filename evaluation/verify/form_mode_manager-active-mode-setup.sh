#!/usr/bin/env bash
# Introspection SETUP: create form mode node.fmm_known and activate it on Article (create the
# entity_form_display node.article.fmm_known). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Entity\Entity\EntityFormMode;
  if (!EntityFormMode::load("node.fmm_known")) {
    EntityFormMode::create(["id" => "node.fmm_known", "label" => "FMM Known", "targetEntityType" => "node"])->save();
  }
  $s = \Drupal::entityTypeManager()->getStorage("entity_form_display");
  if (!$s->load("node.article.fmm_known")) {
    $s->create(["targetEntityType" => "node", "bundle" => "article", "mode" => "fmm_known", "status" => TRUE])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: form mode fmm_known active on node.article (entity_form_display node.article.fmm_known)"
