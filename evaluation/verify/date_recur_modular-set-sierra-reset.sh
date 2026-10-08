#!/usr/bin/env bash
# Execution RESET for "set the Sierra modular widget on a date_recur field".
# Guarantees a clean, FAILING starting state:
#   - ensures a date_recur field (node.article field_eval_recur_s) EXISTS (creates it if needed),
#   - forces its form-display widget to the NON-modular default (date_recur_basic_widget),
#     so verify FAILs until the agent switches it to date_recur_modular_sierra.
# The Article content type ships with standard installs. Idempotent. Rebuilds caches. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_eval_recur_s")) {
    \Drupal\field\Entity\FieldStorageConfig::create([
      "field_name" => "field_eval_recur_s",
      "entity_type" => "node",
      "type" => "date_recur",
      "settings" => ["datetime_type" => "datetime"],
    ])->save();
  }
  if (!\Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_eval_recur_s")) {
    \Drupal\field\Entity\FieldConfig::create([
      "field_name" => "field_eval_recur_s",
      "entity_type" => "node",
      "bundle" => "article",
      "label" => "Eval recurring date (sierra)",
    ])->save();
  }
  \Drupal::service("entity_display.repository")
    ->getFormDisplay("node", "article", "default")
    ->setComponent("field_eval_recur_s", ["type" => "date_recur_basic_widget", "settings" => []])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_eval_recur_s present, form widget = date_recur_basic_widget (non-modular)"
