#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Introspection CLEANUP: remove the facet and facet source created by the matching setup,
# restoring the baseline. Delete facet before source. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($facet = \Drupal::entityTypeManager()->getStorage("facets_facet")->load("eval_coder_facet")) { $facet->delete(); }
  if ($src = \Drupal::entityTypeManager()->getStorage("facets_facet_source")->load("eval_coder_source")) { $src->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: eval_coder_facet + eval_coder_source removed"
