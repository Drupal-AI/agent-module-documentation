#!/usr/bin/env bash
# Execution RESET: ensure bundle 'smm_ct' exists (targets main) and remove any simple_mega_menu
# entities in it, so verify FAILS until the agent creates the 'SMM Promo' entity. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\simple_megamenu\Entity\SimpleMegaMenuType;
  if (!SimpleMegaMenuType::load("smm_ct")) {
    SimpleMegaMenuType::create(["id" => "smm_ct", "label" => "SMM CT", "targetMenu" => ["main" => "main"]])->save();
  }
  $st = \Drupal::entityTypeManager()->getStorage("simple_mega_menu");
  if ($ids = $st->getQuery()->accessCheck(FALSE)->condition("type", "smm_ct")->execute()) {
    $st->delete($st->loadMultiple($ids));
  }
' >/dev/null 2>&1
echo "reset: bundle smm_ct present, no entities"
