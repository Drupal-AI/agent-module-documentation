#!/usr/bin/env bash
# Introspection SETUP: ensure fixture exists and set components=[satisfaction,newsletter], in_draft=true.
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
  $w->setThirdPartySetting("webform_analysis", "components", ["satisfaction", "newsletter"]);
  $w->setThirdPartySetting("webform_analysis", "in_draft", TRUE);
  $w->save();
' >/dev/null 2>&1
echo "setup: wanalysis_fixture components=[satisfaction,newsletter] in_draft=true"
