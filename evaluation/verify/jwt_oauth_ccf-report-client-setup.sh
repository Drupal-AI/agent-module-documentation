#!/usr/bin/env bash
# Introspection SETUP: create a known OAuth client credential for uid 1 with
# client_id "jwtccf_report_client" and label "jwtccf_report", so an inspecting
# agent can report its label and confirm it belongs to uid 1. Idempotent.
# Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $repo = \Drupal::service("jwt_oauth_ccf.client_repository");
  $repo->deleteClient("jwtccf_report_client");
  $repo->createClient(1, "jwtccf_report", NULL, "jwtccf_report_client");
' >/dev/null 2>&1
echo "setup: uid 1 has OAuth client jwtccf_report_client (label jwtccf_report)"
