#!/usr/bin/env bash
# Execution RESET: ensure no IdP 'smlsp_task' exists so verify FAILS until the agent registers it.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\saml_sp\Entity\Idp; if ($i = Idp::load("smlsp_task")) { $i->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: IdP 'smlsp_task' absent"
