#!/usr/bin/env bash
# Introspection SETUP: create an image style flagged to be compressed with TinyPNG
# (third_party_setting tinypng.tinypng_compress=TRUE) so an agent can read back which style
# has it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  $s = ImageStyle::load("tinypng_intro");
  if (!$s) { $s = ImageStyle::create(["name" => "tinypng_intro", "label" => "TinyPNG Intro"]); }
  $s->setThirdPartySetting("tinypng", "tinypng_compress", TRUE);
  $s->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: image style tinypng_intro has tinypng.tinypng_compress=TRUE"
