#!/usr/bin/env bash
# Execution RESET: (re)create the webform wfx_task with two submissions and remove any
# previously exported file, so the verify below fails on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -f /tmp/wfx_task_export.xlsx
drush php:eval '
  use Drupal\webform\Entity\Webform;
  use Drupal\webform\Entity\WebformSubmission;
  $w = Webform::load("wfx_task");
  if (!$w) {
    $w = Webform::create(["id" => "wfx_task", "title" => "WFX Task"]);
    $w->setElements([
      "name" => ["#type" => "textfield", "#title" => "Name"],
      "colour" => ["#type" => "textfield", "#title" => "Colour"],
    ]);
    $w->save();
  }
  $w->deleteState("results.export");
  $existing = \Drupal::entityTypeManager()->getStorage("webform_submission")
    ->loadByProperties(["webform_id" => "wfx_task"]);
  foreach ($existing as $s) { $s->delete(); }
  foreach ([["Alice", "red"], ["Bob", "blue"]] as [$n, $c]) {
    WebformSubmission::create([
      "webform_id" => "wfx_task",
      "data" => ["name" => $n, "colour" => $c],
    ])->save();
  }
' >/dev/null 2>&1
echo "reset: webform wfx_task with 2 submissions; /tmp/wfx_task_export.xlsx removed"
