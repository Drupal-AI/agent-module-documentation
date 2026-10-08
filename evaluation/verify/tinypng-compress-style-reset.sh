#!/usr/bin/env bash
# Execution RESET: ensure image style tinypng_task exists but is NOT flagged for TinyPNG
# compression (third_party_setting removed), so verify FAILS until the agent enables it.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  $s = ImageStyle::load("tinypng_task");
  if (!$s) { $s = ImageStyle::create(["name" => "tinypng_task", "label" => "TinyPNG Task"]); $s->save(); $s = ImageStyle::load("tinypng_task"); }
  $s->unsetThirdPartySetting("tinypng", "tinypng_compress");
  $s->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: image style tinypng_task present, tinypng_compress unset"
