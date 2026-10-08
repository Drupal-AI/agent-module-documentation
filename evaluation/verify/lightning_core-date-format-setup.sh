#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Introspection SETUP: set the pattern of the `long_12h` date format that Lightning Core
# installs (core.date_format.long_12h) to a fixed, distinctive value so an inspecting agent
# (drush) can read the currently-configured pattern back. Idempotent. The shipped baseline
# pattern is restored by the matching cleanup script.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("core.date_format.long_12h")
    ->set("pattern", "Y/m/d h:i A")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: long_12h date format pattern set to 'Y/m/d h:i A'"
