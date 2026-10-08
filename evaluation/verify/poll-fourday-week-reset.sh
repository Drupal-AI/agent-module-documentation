#!/usr/bin/env bash
# Execution reset: clear any poll whose question matches the four-day-week task so the
# case starts from empty state (verify must FAIL before the agent builds anything).
# Paths relative to /var/www/html.
set -uo pipefail
cd /var/www/html

drush php:eval '
$storage = \Drupal::entityTypeManager()->getStorage("poll");
$n = 0;
foreach ($storage->loadMultiple() as $p) {
  if (stripos($p->label(), "four-day work week") !== FALSE
      || stripos($p->label(), "four day work week") !== FALSE) { $p->delete(); $n++; }
}
print "reset: removed $n matching poll(s)\n";
' 2>/dev/null | grep -a '^reset:'
drush cr >/dev/null 2>&1
echo "reset: four-day-week polls cleared"
