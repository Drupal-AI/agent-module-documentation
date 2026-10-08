#!/usr/bin/env bash
# Execution RESET: delete text format tocjsf_new so verify FAILS until the agent creates it with the
# [toc] filter enabled.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\filter\Entity\FilterFormat; if ($f = FilterFormat::load("tocjsf_new")) { $f->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: text format tocjsf_new removed"
