#!/usr/bin/env bash
# Introspection SETUP: create a simple_mega_menu_type bundle 'smm_known' that targets the 'main'
# menu, so an inspecting agent can read which menu it applies to. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\simple_megamenu\Entity\SimpleMegaMenuType;
  if (!SimpleMegaMenuType::load("smm_known")) {
    SimpleMegaMenuType::create(["id" => "smm_known", "label" => "SMM Known", "targetMenu" => ["main" => "main"]])->save();
  } else {
    $t = SimpleMegaMenuType::load("smm_known"); $t->setTargetMenu(["main" => "main"]); $t->save();
  }
' >/dev/null 2>&1
echo "setup: simple_mega_menu_type smm_known targets menu 'main'"
