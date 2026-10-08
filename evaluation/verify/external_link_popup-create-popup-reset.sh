#!/usr/bin/env bash
# Execution RESET: ensure the external_link_popup config entity elp_task does NOT exist, so
# verify FAILS until the agent creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\external_link_popup\Entity\ExternalLinkPopup;
  if ($p = ExternalLinkPopup::load("elp_task")) { $p->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: elp_task absent"
