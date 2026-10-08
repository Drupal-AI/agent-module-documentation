#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# HARD reset: delete any Simple Popup Blocks popup config object that targets the "exit-offer"
# selector, so the "create a bottom-right exit-intent popup" build starts from a state that
# FAILS verify. Leaves other popups untouched. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cf = \Drupal::configFactory();
  foreach ($cf->listAll("simple_popup_blocks.popup_") as $name) {
    if ((string) $cf->get($name)->get("identifier") === "exit-offer") {
      $cf->getEditable($name)->delete();
    }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: removed any simple_popup_blocks popup targeting exit-offer"
