#!/usr/bin/env bash
# Introspection SETUP: create a single site settings type sstp_list_type so the submodule's
# permission callback generates its eight per-type permissions, which the agent must enumerate
# from the running site's permission list. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\site_settings\Entity\SiteSettingEntityType;
  if (!SiteSettingEntityType::load("sstp_list_type")) {
    SiteSettingEntityType::create(["id" => "sstp_list_type", "label" => "SSTP List Type", "group" => "", "multiple" => TRUE])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
drush php:eval '
  $p = \Drupal::service("user.permissions")->getPermissions();
  $found = array_values(array_filter(array_keys($p), fn($n) => str_contains($n, "sstp_list_type")));
  print count($found) . " permissions: " . implode(" | ", $found) . "\n";
' 2>/dev/null
echo "setup: site settings type sstp_list_type created"
