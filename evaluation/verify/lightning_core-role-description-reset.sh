#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Execution RESET: ensure the target role does not yet exist, so the case starts from
# empty state and the agent must actually create it with a Lightning Core description.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($e = \Drupal::entityTypeManager()->getStorage("user_role")->load("eval_content_editor")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role eval_content_editor removed (clean state)"
