#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# MEDIUM (introspection) setup for perimeter.
# Puts perimeter.settings into a KNOWN non-default state: restore the install
# defaults, then APPEND one distinctive custom regex pattern
# (/\/eval-trap-9f3a\//) to not_found_exception_patterns. The agent must inspect
# the live config and report the custom pattern that a stock install would not have.
# Cleanup restores the install defaults.
set -uo pipefail
cd /var/www/html

drush php:eval '
  $f = \Drupal::service("extension.list.module")->getPath("perimeter")."/config/install/perimeter.settings.yml";
  $data = \Drupal\Component\Serialization\Yaml::decode(file_get_contents($f));
  $data["not_found_exception_patterns"][] = "/\/eval-trap-9f3a\//";
  \Drupal::configFactory()->getEditable("perimeter.settings")->setData($data)->save();
  print "setup: appended custom pattern /\/eval-trap-9f3a\// (".count($data["not_found_exception_patterns"])." total)\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
