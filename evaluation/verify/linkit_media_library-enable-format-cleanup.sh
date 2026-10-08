#!/usr/bin/env bash
# Execution CLEANUP: delete the throwaway editor, text format and Linkit profile. Restores
# baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\linkit\Entity\Profile;
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("lml_task_format")) { $e->delete(); }
  if ($f = FilterFormat::load("lml_task_format")) { $f->delete(); }
  if ($p = Profile::load("lml_wire_profile")) { $p->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: lml_task_format editor/format and lml_wire_profile removed"
