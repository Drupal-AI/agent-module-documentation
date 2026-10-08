#!/usr/bin/env bash
# Introspection SETUP: create a rate_widget 'rate_probe' (fivestar / percent) attached to
# node.article so an inspecting agent can read back its template and target bundle. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\rate\Entity\RateWidget;
  if (!\Drupal::entityTypeManager()->getStorage("rate_widget")->load("rate_probe")) {
    RateWidget::create([
      "id" => "rate_probe", "label" => "Rate Probe",
      "template" => "fivestar", "value_type" => "percent",
      "options" => [
        ["value" => 0, "label" => "1", "class" => "", "function" => ""],
        ["value" => 100, "label" => "5", "class" => "", "function" => ""],
      ],
      "entity_types" => ["node.article"],
      "comment_types" => [],
      "voting" => ["use_deadline" => 0, "anonymous_window" => -2, "user_window" => -2],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: rate_widget rate_probe (fivestar/percent) attached to node.article"
