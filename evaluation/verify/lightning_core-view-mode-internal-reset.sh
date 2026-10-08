#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Execution RESET: delete the target node view mode so the case starts empty; the agent
# must create it and mark it internal + described via Lightning Core.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($e = \Drupal::entityTypeManager()->getStorage("entity_view_mode")->load("node.eval_summary")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view mode node.eval_summary removed (clean state)"
