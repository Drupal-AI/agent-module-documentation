#!/usr/bin/env bash
# Execution RESET: ensure fixture exists and clear its webform_analysis settings so verify FAILS.
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
  $w->unsetThirdPartySetting("webform_analysis", "chart_type");
  $w->unsetThirdPartySetting("webform_analysis", "components");
  $w->save();
' >/dev/null 2>&1
echo "reset: wanalysis_fixture webform_analysis settings cleared"
