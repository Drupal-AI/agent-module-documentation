#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# HARD (execution) reset for decoupled_router: ensure the target path does NOT
# resolve yet. Deletes the /dr-resolved-page alias and any node created by a prior
# run (matched by the eval marker title), so verify FAILs on empty state.
set -uo pipefail
cd /var/www/html

drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("path_alias")->loadByProperties(["alias" => "/dr-resolved-page"]) as $a) { $a->delete(); }
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "DR Resolved Page"]) as $n) { $n->delete(); }
  print "reset: /dr-resolved-page alias + marker node removed\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
