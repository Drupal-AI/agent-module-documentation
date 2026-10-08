#!/usr/bin/env bash
# Introspection SETUP: create paragraph type pvm_known with the paragraphs_viewmode_behavior
# enabled, override_default=teaser, so an agent can read back which type has the behavior and
# its default view mode. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\paragraphs\Entity\ParagraphsType;
  if (!ParagraphsType::load("pvm_known")) {
    ParagraphsType::create(["id"=>"pvm_known","label"=>"PVM Known"])->save();
  }
  $pt = ParagraphsType::load("pvm_known");
  $pt->set("behavior_plugins", [
    "paragraphs_viewmode_behavior" => [
      "enabled" => TRUE,
      "override_mode" => "default",
      "override_available" => ["default"=>"default","teaser"=>"teaser"],
      "override_default" => "teaser",
    ],
  ]);
  $pt->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: paragraphs_type pvm_known has paragraphs_viewmode_behavior enabled, override_default=teaser"
