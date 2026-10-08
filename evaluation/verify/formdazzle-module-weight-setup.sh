#!/usr/bin/env bash
# Introspection SETUP: set formdazzle's module weight to a distinctive known value (7) in
# core.extension, so an inspecting agent can read the live module weight back. formdazzle's
# weight matters because it must run after other modules' hook_form_alter. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'module_set_weight("formdazzle", 7);' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: formdazzle module weight set to 7"
