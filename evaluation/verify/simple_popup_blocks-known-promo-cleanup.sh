#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Introspection CLEANUP: delete the known popup config object created by the promo setup,
# restoring baseline (no such popup ships by default). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("simple_popup_blocks.popup_known_promo")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: simple_popup_blocks.popup_known_promo removed"
