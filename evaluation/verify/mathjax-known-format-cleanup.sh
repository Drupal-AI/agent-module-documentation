#!/usr/bin/env bash
# Introspection CLEANUP: delete both throwaway text formats. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  foreach (["mathjax_eval_on", "mathjax_eval_off"] as $id) {
    if ($f = FilterFormat::load($id)) { $f->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: mathjax_eval_on / mathjax_eval_off text formats removed"
