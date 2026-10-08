#!/usr/bin/env bash
# Introspection SETUP: create ECA model ecawf_known with one action using the eca_webform
# 'Set submission data' plugin (eca_webform_submission_set_data), so an agent can read back
# which action plugin the model uses. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("eca");
  if ($e = $s->load("ecawf_known")) { $e->delete(); }
  $s->create([
    "id" => "ecawf_known", "label" => "ECA Webform Known", "status" => TRUE,
    "modeller" => "core", "version" => "",
    "events" => [], "conditions" => [], "gateways" => [],
    "actions" => [
      "act_set" => [
        "plugin" => "eca_webform_submission_set_data",
        "label" => "Set submission data",
        "configuration" => ["field_name" => "email", "field_value" => "[current-user:mail]"],
        "successors" => [],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: eca model ecawf_known action plugin=eca_webform_submission_set_data"
