#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Introspection CLEANUP: remove the known eval_intro_erf_ref View, restoring baseline.
# Idempotent: no-op if already gone. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($v = \Drupal::entityTypeManager()->getStorage("view")->load("eval_intro_erf_ref")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: view eval_intro_erf_ref removed"
