#!/usr/bin/env bash
# Execution CLEANUP (field): delete view vmsw_fview, workflow vmsw_fflow, type vmsw_ftype. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\workflows\Entity\Workflow;
  use Drupal\views\Entity\View;
  if ($v=View::load("vmsw_fview")) $v->delete();
  if ($w=Workflow::load("vmsw_fflow")) $w->delete();
  if ($t=NodeType::load("vmsw_ftype")) $t->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: vmsw_fview / vmsw_fflow / vmsw_ftype removed"
