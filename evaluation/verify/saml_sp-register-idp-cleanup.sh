#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\saml_sp\Entity\Idp; if ($i = Idp::load("smlsp_task")) { $i->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: IdP 'smlsp_task' removed"
