#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Execution RESET: clear state so the "build a view using the term-name-depth argument"
# task starts empty. Deletes the target view `eval_vttnd_build` if present. Idempotent.
# Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($v = \Drupal::entityTypeManager()->getStorage("view")->load("eval_vttnd_build")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view eval_vttnd_build removed"
