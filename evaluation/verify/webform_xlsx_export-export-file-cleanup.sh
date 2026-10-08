#!/usr/bin/env bash
# Execution CLEANUP: delete the wfx_task webform (and its submissions) and the export file.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -f /tmp/wfx_task_export.xlsx
drush php:eval '
  use Drupal\webform\Entity\Webform;
  if ($w = Webform::load("wfx_task")) { $w->delete(); }
' >/dev/null 2>&1
echo "cleanup: wfx_task webform and /tmp/wfx_task_export.xlsx removed"
