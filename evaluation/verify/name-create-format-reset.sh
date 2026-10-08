#!/usr/bin/env bash
# Execution RESET: ensure the name_format entity `name_hardfmt` does NOT exist, so verify FAILS
# until the agent creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\name\Entity\NameFormat;
  if ($e = NameFormat::load("name_hardfmt")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: name.name_format.name_hardfmt absent"
