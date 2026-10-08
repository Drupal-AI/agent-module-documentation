#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# HARD (execution) reset for domain: clear eval domain records so verify FAILs on
# empty state. The agent must then CREATE a domain record for news.eval.example.com.
# Only touches eval-prefixed ids; never real domains.
set -uo pipefail
cd /var/www/html

drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("domain");
  $n = 0;
  foreach ($s->loadMultiple() as $d) { if (str_starts_with($d->id(), "eval")) { $d->delete(); $n++; } }
  print "reset: cleared $n eval domain(s)\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
