#!/usr/bin/env bash
# Introspection SETUP: install a KNOWN field_validation_rule_set so an inspecting agent can
# read it back with drush. Rule set `eval_intro_set` targets node/article and holds two rules:
#   - length_constraint_rule on the `title` field: min 10, max 60
#   - regex_constraint_rule on the `body` field:   pattern /^[A-Z].*/
# These do not ship by default, so creating/deleting the set is safe. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field_validation\Entity\FieldValidationRuleSet;
  if ($e = FieldValidationRuleSet::load("eval_intro_set")) { $e->delete(); }
  $u1 = \Drupal::service("uuid")->generate();
  $u2 = \Drupal::service("uuid")->generate();
  FieldValidationRuleSet::create([
    "name" => "eval_intro_set",
    "label" => "Eval Intro Set",
    "entity_type" => "node",
    "bundle" => "article",
    "field_validation_rules" => [
      $u1 => [
        "id" => "length_constraint_rule", "uuid" => $u1, "title" => "Title length",
        "weight" => 0, "field_name" => "title", "column" => "value", "error_message" => "",
        "roles" => [], "condition" => [],
        "data" => ["validate_mode" => "default", "min" => "10", "max" => "60"],
      ],
      $u2 => [
        "id" => "regex_constraint_rule", "uuid" => $u2, "title" => "Body starts uppercase",
        "weight" => 1, "field_name" => "body", "column" => "value", "error_message" => "",
        "roles" => [], "condition" => [],
        "data" => ["validate_mode" => "default", "pattern" => "/^[A-Z].*/", "message" => "Must start with a capital."],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_validation_rule_set eval_intro_set (node/article: title length 10-60, body regex /^[A-Z].*/) created"
