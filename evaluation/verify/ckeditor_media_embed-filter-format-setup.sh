#!/usr/bin/env bash
# Introspection SETUP: create a text format ckme_probe_format with the
# "Convert Oembed tags to media embeds" (filter_ckeditor_media_embed) filter ENABLED,
# so an agent can discover which format converts oEmbed tags. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("ckme_probe_format");
  if (!$f) {
    $f = FilterFormat::create(["format" => "ckme_probe_format", "name" => "CKME Probe Format", "weight" => 40]);
  }
  $f->setFilterConfig("filter_ckeditor_media_embed", ["status" => TRUE, "weight" => 0, "settings" => []]);
  $f->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: text format ckme_probe_format created with filter_ckeditor_media_embed enabled"
