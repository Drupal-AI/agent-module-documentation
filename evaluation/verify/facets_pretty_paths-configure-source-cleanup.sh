#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Execution CLEANUP: remove the facets_facet_source created for the hard task, leaving the
# site clean. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($src = \Drupal::entityTypeManager()->getStorage("facets_facet_source")->load("eval_hard_source")) { $src->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: facets_facet_source eval_hard_source removed"
