#!/usr/bin/env bash
# Execution CLEANUP: remove the fmm_task display + form mode. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Entity\Entity\EntityFormMode;
  if ($d = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.fmm_task")) { $d->delete(); }
  if ($m = EntityFormMode::load("node.fmm_task")) { $m->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: fmm_task display + form mode removed"
