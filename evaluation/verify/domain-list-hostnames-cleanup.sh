#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# MEDIUM (introspection) cleanup for domain: delete the eval domain records the
# setup created. Only removes eval-prefixed ids; leaves any real domains untouched.
set -uo pipefail
cd /var/www/html

drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("domain");
  $n = 0;
  foreach ($s->loadMultiple() as $d) { if (str_starts_with($d->id(), "eval")) { $d->delete(); $n++; } }
  print "cleanup: removed $n eval domain(s)\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
