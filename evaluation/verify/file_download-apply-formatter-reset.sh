#!/usr/bin/env bash
# Execution RESET: ensure file field field_fd_task on Article displays with the GENERIC file formatter
# (file_default), NOT file_download_formatter, so verify FAILs until the agent switches it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_fd_task")) { FieldStorageConfig::create(["field_name"=>"field_fd_task","entity_type"=>"node","type"=>"file"])->save(); }
  if (!FieldConfig::loadByName("node","article","field_fd_task")) { FieldConfig::create(["field_name"=>"field_fd_task","entity_type"=>"node","bundle"=>"article","label"=>"FD Task"])->save(); }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_fd_task", ["type"=>"file_default","label"=>"above","weight"=>51,"region"=>"content","settings"=>[]])->save();
' >/dev/null 2>&1
echo "reset: field_fd_task displays with generic file_default formatter (no file_download)"
