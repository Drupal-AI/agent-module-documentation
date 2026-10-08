#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\cms_content_sync\Entity\Pool;
  use Drupal\cms_content_sync\Entity\Flow;
  if ($p = Pool::load("ccs_ach_pool")) { $p->delete(); }
  if ($f = Flow::load("ccs_ach_flow")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ccs_ach_pool and ccs_ach_flow removed"
