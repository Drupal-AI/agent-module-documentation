#!/usr/bin/env bash
# Introspection SETUP: create a bundle 'smm_probe' and one simple_mega_menu entity named
# 'SMM Known Panel' in it, so an agent can read the entity's name back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\simple_megamenu\Entity\SimpleMegaMenuType;
  use Drupal\simple_megamenu\Entity\SimpleMegaMenu;
  if (!SimpleMegaMenuType::load("smm_probe")) {
    SimpleMegaMenuType::create(["id" => "smm_probe", "label" => "SMM Probe", "targetMenu" => ["main" => "main"]])->save();
  }
  $existing = \Drupal::entityTypeManager()->getStorage("simple_mega_menu")
    ->loadByProperties(["type" => "smm_probe", "name" => "SMM Known Panel"]);
  if (!$existing) {
    SimpleMegaMenu::create(["type" => "smm_probe", "name" => "SMM Known Panel", "status" => 1])->save();
  }
' >/dev/null 2>&1
echo "setup: simple_mega_menu 'SMM Known Panel' created in bundle smm_probe"
