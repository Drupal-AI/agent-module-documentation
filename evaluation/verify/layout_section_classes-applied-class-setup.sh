#!/usr/bin/env bash
# Introspection SETUP: ensure the lsc_fixture layout provider is installed, create content type
# lsc_demo, enable Layout Builder on its default view display with a single section using the
# classy layout lsc_fixture_layout and the 'bg-muted' style class applied, so an agent can read
# back which section class is configured. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\layout_builder\Section;
  if (!\Drupal::moduleHandler()->moduleExists("lsc_fixture")) { \Drupal::service("module_installer")->install(["lsc_fixture"]); }
  if (!NodeType::load("lsc_demo")) { NodeType::create(["type" => "lsc_demo", "name" => "LSC Demo"])->save(); }
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node", "lsc_demo", "default");
  $vd->enableLayoutBuilder();
  $vd->setThirdPartySetting("layout_builder", "sections", [new Section("lsc_fixture_layout", ["additional" => ["classes" => ["style" => "bg-muted"]]])]);
  $vd->save();
' >/dev/null 2>&1
echo "setup: node.lsc_demo.default LB section (lsc_fixture_layout) has style class bg-muted"
