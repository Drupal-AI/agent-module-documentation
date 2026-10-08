#!/usr/bin/env bash
# Introspection SETUP: create ECA model ecawf_field with an eca_webform 'Get submission data'
# action (eca_webform_submission_get_data) that reads element 'email' into token 'submitted_email',
# so an agent can read back the token_name. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("eca");
  if ($e = $s->load("ecawf_field")) { $e->delete(); }
  $s->create([
    "id" => "ecawf_field", "label" => "ECA Webform Field", "status" => TRUE,
    "modeller" => "core", "version" => "",
    "events" => [], "conditions" => [], "gateways" => [],
    "actions" => [
      "act_get" => [
        "plugin" => "eca_webform_submission_get_data",
        "label" => "Get submission data",
        "configuration" => ["field_name" => "email", "token_name" => "submitted_email"],
        "successors" => [],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: eca model ecawf_field get-data token_name=submitted_email"
