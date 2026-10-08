#!/usr/bin/env bash
# Execution RESET: create text format oe_task_format WITHOUT the obfuscate_email filter, so verify
# FAILS until the agent enables it. Idempotent (recreates the format each time). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("oe_task_format")) { $f->delete(); }
  FilterFormat::create(["format" => "oe_task_format", "name" => "OE Task Format"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: oe_task_format exists without obfuscate_email"
