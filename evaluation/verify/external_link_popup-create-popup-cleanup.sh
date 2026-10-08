#!/usr/bin/env bash
# Execution CLEANUP: delete the elp_task pop-up. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\external_link_popup\Entity\ExternalLinkPopup;
  if ($p = ExternalLinkPopup::load("elp_task")) { $p->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: elp_task removed"
