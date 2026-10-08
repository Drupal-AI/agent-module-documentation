#!/usr/bin/env bash
# Introspection SETUP: create a webform and persist XLSX as its saved results-export
# settings (webform state key 'results.export'), so an agent can read the live setting back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  $w = Webform::load("wfx_known");
  if (!$w) {
    $w = Webform::create(["id" => "wfx_known", "title" => "WFX Known"]);
    $w->setElements(["name" => ["#type" => "textfield", "#title" => "Name"]]);
    $w->save();
  }
  $options = \Drupal::service("webform_submission.exporter")->getDefaultExportOptions();
  $options["exporter"] = "xlsx";
  $options["header_format"] = "key";
  $options["file_name"] = "wfx-known-report";
  $w->setState("results.export", $options);
' >/dev/null 2>&1
echo "setup: webform wfx_known has saved export settings with exporter=xlsx"
