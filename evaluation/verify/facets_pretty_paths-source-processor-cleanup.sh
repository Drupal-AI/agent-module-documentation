#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Introspection CLEANUP: remove the known facets_facet_source created by the matching setup,
# restoring the baseline (no eval facet source). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("facets_facet_source");
  if ($src = $storage->load("eval_pretty_source")) { $src->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: facets_facet_source eval_pretty_source removed"
