#!/usr/bin/env bash
# Execution RESET: ensure no VBO export action (plugin bibcite_export_multiple_vbo) exists so
# verify FAILS until the agent creates it. Running reset again = cleanup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Action;
  foreach (Action::loadMultiple() as $a) { if ((string) $a->get("plugin") === "bibcite_export_multiple_vbo") { $a->delete(); } }
' >/dev/null 2>&1 || true
echo "reset: no bibcite_export_multiple_vbo action"
