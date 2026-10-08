#!/usr/bin/env bash
# Introspection CLEANUP: remove the fmm_known form display + form mode. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Entity\Entity\EntityFormMode;
  if ($d = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.fmm_known")) { $d->delete(); }
  if ($m = EntityFormMode::load("node.fmm_known")) { $m->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: fmm_known display + form mode removed"
