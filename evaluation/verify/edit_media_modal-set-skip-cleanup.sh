#!/usr/bin/env bash
# Execution CLEANUP: delete the emm_probe editor config (baseline: absent). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("editor.editor.emm_probe")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: editor.editor.emm_probe deleted"
