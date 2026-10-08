#!/usr/bin/env bash
# Introspection SETUP: install a KNOWN field_group group on the node.article.default
# entity_form_display so an inspecting agent can read it back via drush. Installs group
# `group_eval_publish` (label "Publishing Options", format_type fieldset, children
# body + field_eval_sections). Idempotent: overwrites any prior copy. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $d = \Drupal::service("entity_display.repository")->getFormDisplay("node", "article", "default");
  $d->setThirdPartySetting("field_group", "group_eval_publish", [
    "label" => "Publishing Options",
    "children" => ["body", "field_eval_sections"],
    "parent_name" => "",
    "region" => "content",
    "weight" => 20,
    "format_type" => "fieldset",
    "format_settings" => [
      "classes" => "",
      "id" => "",
      "description" => "",
      "required_fields" => TRUE,
    ],
  ]);
  $d->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_group group_eval_publish installed on node.article.default form display (label 'Publishing Options', format_type fieldset, children body,field_eval_sections)"
