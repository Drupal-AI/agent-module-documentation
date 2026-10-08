#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Introspection CLEANUP: restore the long_12h date format to the exact pattern Lightning
# Core ships in config/install. The PHP literal is single-quoted (via '\'') so the '\a\t'
# escape sequence stays literal and no TAB is introduced.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("core.date_format.long_12h")
    ->set("pattern", '\''F j, Y \a\t g:i A'\'')->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: long_12h date format pattern restored to baseline"
