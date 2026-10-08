#!/usr/bin/env bash
# Execution RESET: create/ensure a rate_widget 'rate_ro' attached to node.article with
# display.readonly = 0 (votable), so verify FAILS until the agent makes it read-only. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\rate\Entity\RateWidget;
  $storage = \Drupal::entityTypeManager()->getStorage("rate_widget");
  $w = $storage->load("rate_ro");
  if (!$w) {
    $w = RateWidget::create([
      "id" => "rate_ro", "label" => "Rate Readonly",
      "template" => "fivestar", "value_type" => "percent",
      "options" => [
        ["value" => 0, "label" => "1", "class" => "", "function" => ""],
        ["value" => 100, "label" => "5", "class" => "", "function" => ""],
      ],
      "entity_types" => ["node.article"],
      "comment_types" => [],
      "voting" => ["use_deadline" => 0, "anonymous_window" => -2, "user_window" => -2],
    ]);
  }
  $display = (array) $w->get("display");
  $display["readonly"] = 0;
  $w->set("display", $display)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: rate_widget rate_ro present with display.readonly=0"
