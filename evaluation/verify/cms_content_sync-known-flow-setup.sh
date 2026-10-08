#!/usr/bin/env bash
# Introspection SETUP: create a known cms_content_sync Flow (variant=simple, type=both) so an
# agent can read its variant back from live config. Config-only; no backend contact.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\cms_content_sync\Entity\Flow;
  if (!Flow::load("ccs_known_flow")) {
    Flow::create([
      "id" => "ccs_known_flow", "name" => "CCS Known Flow", "type" => "both",
      "variant" => "simple", "simple_settings" => [], "per_bundle_settings" => [],
      "sync_entities" => [],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: flow ccs_known_flow variant=simple type=both"
