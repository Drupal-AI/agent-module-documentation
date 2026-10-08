#!/usr/bin/env bash
# Execution RESET: ensure file field field_fd_uri on Article displays with the GENERIC file formatter
# (file_default), so verify FAILs until the agent switches it to file_download_uri_formatter. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_fd_uri")) { FieldStorageConfig::create(["field_name"=>"field_fd_uri","entity_type"=>"node","type"=>"file"])->save(); }
  if (!FieldConfig::loadByName("node","article","field_fd_uri")) { FieldConfig::create(["field_name"=>"field_fd_uri","entity_type"=>"node","bundle"=>"article","label"=>"FD Uri"])->save(); }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_fd_uri", ["type"=>"file_default","label"=>"above","weight"=>52,"region"=>"content","settings"=>[]])->save();
' >/dev/null 2>&1
echo "reset: field_fd_uri displays with generic file_default formatter"
