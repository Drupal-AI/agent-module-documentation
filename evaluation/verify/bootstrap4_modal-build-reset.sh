#!/usr/bin/env bash
# Execution RESET: ensure no b4m_build entity browser exists (so verify FAILS until built).
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\entity_browser\Entity\EntityBrowser; if ($eb = EntityBrowser::load("b4m_build")) { $eb->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: entity_browser.browser.b4m_build absent"
