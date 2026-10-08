#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Introspection CLEANUP: remove the known Lightning Core-described role.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($e = \Drupal::entityTypeManager()->getStorage("user_role")->load("eval_lc_role")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: role eval_lc_role removed"
