#!/usr/bin/env bash
# Execution RESET: ensure form mode node.fmm_task EXISTS but is NOT activated on Article
# (delete the entity_form_display node.article.fmm_task) so verify FAILS until the agent
# activates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Entity\Entity\EntityFormMode;
  if (!EntityFormMode::load("node.fmm_task")) {
    EntityFormMode::create(["id" => "node.fmm_task", "label" => "FMM Task", "targetEntityType" => "node"])->save();
  }
  if ($d = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.fmm_task")) { $d->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: form mode node.fmm_task exists, NOT activated on article"
