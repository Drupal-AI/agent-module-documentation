#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# HARD (execution) cleanup for the "add an xmlrpc.php ban pattern" task: restore
# perimeter.settings to the module's install defaults, leaving the site clean.
set -uo pipefail
cd /var/www/html

drush php:eval '
  $f = \Drupal::service("extension.list.module")->getPath("perimeter")."/config/install/perimeter.settings.yml";
  $data = \Drupal\Component\Serialization\Yaml::decode(file_get_contents($f));
  \Drupal::configFactory()->getEditable("perimeter.settings")->setData($data)->save();
  print "cleanup: perimeter.settings restored to install defaults\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
