#!/usr/bin/env bash
# Introspection cleanup: delete the known eval poll created by poll-known-poll-setup.sh
# (deleting a poll cascades to its choices and votes). Restores baseline. Paths relative
# to /var/www/html.
set -uo pipefail
cd /var/www/html

drush php:eval '
$q = "Which JavaScript framework do you prefer? [eval-known]";
$storage = \Drupal::entityTypeManager()->getStorage("poll");
$n = 0;
foreach ($storage->loadByProperties(["question" => $q]) as $p) { $p->delete(); $n++; }
print "cleanup: removed $n eval poll(s)\n";
' 2>/dev/null | grep -a '^cleanup:'
