#!/usr/bin/env bash
# Execution reset: clear any poll whose question matches the favorite-language task so the
# case starts from empty state (verify must FAIL before the agent builds anything).
# Paths relative to /var/www/html.
set -uo pipefail
cd /var/www/html

drush php:eval '
$storage = \Drupal::entityTypeManager()->getStorage("poll");
$n = 0;
foreach ($storage->loadMultiple() as $p) {
  if (stripos($p->label(), "favorite programming language") !== FALSE
      || stripos($p->label(), "favourite programming language") !== FALSE) { $p->delete(); $n++; }
}
print "reset: removed $n matching poll(s)\n";
' 2>/dev/null | grep -a '^reset:'
drush cr >/dev/null 2>&1
echo "reset: favorite-language polls cleared"
