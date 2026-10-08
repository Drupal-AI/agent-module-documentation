#!/usr/bin/env bash
# Execution CLEANUP (message_subscribe): restore baseline by DISABLING the subscribe_node flag
# (shipped default is disabled). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($f = \Drupal::entityTypeManager()->getStorage("flag")->load("subscribe_node")) {
    if ($f->status()) { $f->disable()->save(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: subscribe_node flag disabled (baseline)"
