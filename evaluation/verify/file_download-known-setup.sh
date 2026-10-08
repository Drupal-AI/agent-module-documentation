#!/usr/bin/env bash
# Introspection SETUP: create a file field field_fd_known on Article and configure its default view
# display to use file_download_formatter with a custom link label ('Grab it now') and file size, so an
# inspecting agent can read the formatter and its custom text. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_fd_known")) { FieldStorageConfig::create(["field_name"=>"field_fd_known","entity_type"=>"node","type"=>"file"])->save(); }
  if (!FieldConfig::loadByName("node","article","field_fd_known")) { FieldConfig::create(["field_name"=>"field_fd_known","entity_type"=>"node","bundle"=>"article","label"=>"FD Known"])->save(); }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_fd_known", ["type"=>"file_download_formatter","label"=>"hidden","weight"=>50,"region"=>"content","settings"=>["link_title"=>"custom","custom_title_text"=>"Grab it now","file_size"=>TRUE]])->save();
' >/dev/null 2>&1
echo "setup: node.article field_fd_known uses file_download_formatter (custom text 'Grab it now', file_size on)"
