#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\field_inheritance\Entity\FieldInheritance; foreach (FieldInheritance::loadMultiple() as $e) { if (strpos($e->id(),"fi_fb")!==FALSE) { $e->delete(); } }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: no field_inheritance matching fi_fb"
