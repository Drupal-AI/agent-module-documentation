#!/usr/bin/env bash
# Execution RESET: ensure lsc_fixture installed; create content type lsc_demo with Layout Builder
# enabled on its default display holding ONE core (layout_onecol) section and NO classy section,
# so verify FAILS until the agent adds a lsc_fixture_layout section with a style class. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\layout_builder\Section;
  if (!\Drupal::moduleHandler()->moduleExists("lsc_fixture")) { \Drupal::service("module_installer")->install(["lsc_fixture"]); }
  if (!NodeType::load("lsc_demo")) { NodeType::create(["type" => "lsc_demo", "name" => "LSC Demo"])->save(); }
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node", "lsc_demo", "default");
  $vd->enableLayoutBuilder();
  $vd->setThirdPartySetting("layout_builder", "sections", [new Section("layout_onecol")]);
  $vd->save();
' >/dev/null 2>&1
echo "reset: node.lsc_demo.default has only a core layout_onecol section (no classy section)"
