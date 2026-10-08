#!/usr/bin/env bash
# Introspection SETUP: refresh the module extension list so the agent can read the real .info.yml
# metadata of the bundled submodule manage_display_fix_title from the running site (its
# `lifecycle` and `core_version_requirement`). Note the submodule is NOT installed and cannot be
# on Drupal 11, so the values must be read with getAllAvailableInfo(), not getExtensionInfo().
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::service("extension.list.module")->reset();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
info=$(drush php:eval '
  $all = \Drupal::service("extension.list.module")->getAllAvailableInfo();
  $a = $all["manage_display_fix_title"] ?? [];
  print ($a["lifecycle"] ?? "none") . " / " . ($a["core_version_requirement"] ?? "none");
' 2>/dev/null)
echo "setup: extension list refreshed; manage_display_fix_title info reports lifecycle/core = ${info}"
