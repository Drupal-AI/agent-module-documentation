#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\user\Entity\Role; if ($r = Role::load("tp_utask")) { $r->delete(); } Role::create(["id"=>"tp_utask","label"=>"TP Uninstall Task"])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role tp_utask present with no per-theme permission"
