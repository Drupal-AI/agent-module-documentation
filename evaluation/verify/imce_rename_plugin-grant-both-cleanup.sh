#!/usr/bin/env bash
# imce_rename_plugin cleanup: delete IMCE profile(s): imcerp_both. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("imce_profile");
  foreach (["imcerp_both"] as $id) { if ($p = $s->load($id)) { $p->delete(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: removed imcerp_both"
