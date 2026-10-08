#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# HARD (execution) reset for the "add an xmlrpc.php ban pattern" task.
# Restore perimeter.settings to the module's install defaults. The 12 default
# patterns do NOT match /xmlrpc.php, so verify FAILs on this baseline; it only
# PASSes after the agent adds a pattern that catches xmlrpc.php.
set -uo pipefail
cd /var/www/html

drush php:eval '
  $f = \Drupal::service("extension.list.module")->getPath("perimeter")."/config/install/perimeter.settings.yml";
  $data = \Drupal\Component\Serialization\Yaml::decode(file_get_contents($f));
  \Drupal::configFactory()->getEditable("perimeter.settings")->setData($data)->save();
  print "reset: perimeter.settings restored to install defaults (".count($data["not_found_exception_patterns"])." patterns, none match xmlrpc.php)\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
