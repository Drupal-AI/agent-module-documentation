#!/usr/bin/env bash
# Introspection SETUP: two webforms with saved export settings -- one uses the XLSX exporter
# added by webform_xlsx_export, the other uses Webform core's delimited (CSV) exporter.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  $defaults = \Drupal::service("webform_submission.exporter")->getDefaultExportOptions();
  foreach (["wfx_pair_a" => "xlsx", "wfx_pair_b" => "delimited"] as $id => $exporter) {
    $w = Webform::load($id);
    if (!$w) {
      $w = Webform::create(["id" => $id, "title" => strtoupper($id)]);
      $w->setElements(["name" => ["#type" => "textfield", "#title" => "Name"]]);
      $w->save();
    }
    $options = $defaults;
    $options["exporter"] = $exporter;
    $w->setState("results.export", $options);
  }
' >/dev/null 2>&1
echo "setup: wfx_pair_a exporter=xlsx, wfx_pair_b exporter=delimited"
