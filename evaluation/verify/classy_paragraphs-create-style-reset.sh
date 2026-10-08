#!/usr/bin/env bash
# HARD reset: clear classy_paragraphs_style config entities so the "create a Callout style"
# task starts from empty state (verify must FAIL before the agent builds anything).
# SPDX-License-Identifier: GPL-2.0-or-later
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("classy_paragraphs_style")->loadMultiple() as $s) { $s->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: all classy_paragraphs_style entities cleared"
