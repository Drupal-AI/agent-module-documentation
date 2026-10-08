#!/usr/bin/env bash
# Execution RESET: ensure lsc_fixture is installed; create content type lsc_demo with Layout Builder
# enabled on its default display holding ONE section using lsc_fixture_layout with NO style class
# (style=''), so verify FAILS until the agent applies the bg-primary class. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\layout_builder\Section;
  if (!\Drupal::moduleHandler()->moduleExists("lsc_fixture")) { \Drupal::service("module_installer")->install(["lsc_fixture"]); }
  if (!NodeType::load("lsc_demo")) { NodeType::create(["type" => "lsc_demo", "name" => "LSC Demo"])->save(); }
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node", "lsc_demo", "default");
  $vd->enableLayoutBuilder();
  $vd->setThirdPartySetting("layout_builder", "sections", [new Section("lsc_fixture_layout", ["additional" => ["classes" => ["style" => ""]]])]);
  $vd->save();
' >/dev/null 2>&1
echo "reset: node.lsc_demo.default section (lsc_fixture_layout) has NO style class"
