#!/usr/bin/env bash
# Execution CLEANUP (sort): delete view vmsw_sview, workflow vmsw_sflow, type vmsw_stype. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\workflows\Entity\Workflow;
  use Drupal\views\Entity\View;
  if ($v=View::load("vmsw_sview")) $v->delete();
  if ($w=Workflow::load("vmsw_sflow")) $w->delete();
  if ($t=NodeType::load("vmsw_stype")) $t->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: vmsw_sview / vmsw_sflow / vmsw_stype removed"
