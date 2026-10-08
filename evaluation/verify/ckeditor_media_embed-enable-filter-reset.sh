#!/usr/bin/env bash
# Execution RESET: (re)create text format ckme_hard_format WITHOUT the oEmbed filter, so verify
# FAILS until the agent enables filter_ckeditor_media_embed on it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("ckme_hard_format")) { $f->delete(); }
  FilterFormat::create([
    "format" => "ckme_hard_format", "name" => "CKME Hard Format", "weight" => 40,
    "filters" => ["filter_html_escape" => ["status" => TRUE, "weight" => 0, "settings" => []]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ckme_hard_format created without filter_ckeditor_media_embed"
