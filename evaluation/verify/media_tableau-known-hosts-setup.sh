#!/usr/bin/env bash
# Introspection SETUP: set a known media_tableau allowed-hosts list (default host plus a
# recognizable eval host) so an inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("media_tableau.settings")
    ->set("allowed_hosts", ["https://public.tableau.com", "https://mtb-eval.example.com"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: media_tableau.settings allowed_hosts = [public.tableau.com, mtb-eval.example.com]"
