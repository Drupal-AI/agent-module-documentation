#!/usr/bin/env bash
# Introspection SETUP: ensure fixture webform wanalysis_fixture exists and set its webform_analysis
# third-party settings to a known state (PieChart, components=[satisfaction]). Toggling tps on an
# existing webform is route-neutral (clean). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  $s = \Drupal::entityTypeManager()->getStorage("webform");
  $w = $s->load("wanalysis_fixture");
  if (!$w) {
    $w = Webform::create(["id" => "wanalysis_fixture", "title" => "WAnalysis Fixture"]);
    $w->setElements(["satisfaction" => ["#type" => "select", "#title" => "Satisfaction", "#options" => ["low" => "Low", "med" => "Medium", "high" => "High"]], "newsletter" => ["#type" => "checkbox", "#title" => "Newsletter"]]);
    $w->save();
    $w = $s->load("wanalysis_fixture");
  }
  $w->setThirdPartySetting("webform_analysis", "chart_type", "PieChart");
  $w->setThirdPartySetting("webform_analysis", "components", ["satisfaction"]);
  $w->save();
' >/dev/null 2>&1
echo "setup: wanalysis_fixture webform_analysis chart_type=PieChart components=[satisfaction]"
