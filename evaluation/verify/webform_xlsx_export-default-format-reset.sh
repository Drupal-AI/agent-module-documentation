#!/usr/bin/env bash
# Execution RESET: (re)create the webform wfx_pref and clear any saved results-export
# settings, so the verify below fails on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  $w = Webform::load("wfx_pref");
  if (!$w) {
    $w = Webform::create(["id" => "wfx_pref", "title" => "WFX Pref"]);
    $w->setElements(["name" => ["#type" => "textfield", "#title" => "Name"]]);
    $w->save();
  }
  $w->deleteState("results.export");
' >/dev/null 2>&1
echo "reset: webform wfx_pref exists with no saved export settings"
