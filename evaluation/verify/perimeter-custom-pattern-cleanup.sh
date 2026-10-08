#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# MEDIUM (introspection) cleanup for perimeter: restore perimeter.settings to the
# module's install defaults (drops the custom /\/eval-trap-9f3a\// pattern and any
# non-default threshold/whitelist).
set -uo pipefail
cd /var/www/html

drush php:eval '
  $f = \Drupal::service("extension.list.module")->getPath("perimeter")."/config/install/perimeter.settings.yml";
  $data = \Drupal\Component\Serialization\Yaml::decode(file_get_contents($f));
  \Drupal::configFactory()->getEditable("perimeter.settings")->setData($data)->save();
  print "cleanup: perimeter.settings restored to install defaults (".count($data["not_found_exception_patterns"])." patterns)\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
