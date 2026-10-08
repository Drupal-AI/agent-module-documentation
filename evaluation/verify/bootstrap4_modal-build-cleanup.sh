#!/usr/bin/env bash
# Execution CLEANUP: remove the b4m_build entity browser. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\entity_browser\Entity\EntityBrowser; if ($eb = EntityBrowser::load("b4m_build")) { $eb->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: entity_browser.browser.b4m_build removed"
