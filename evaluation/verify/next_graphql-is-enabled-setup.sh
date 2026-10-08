#!/usr/bin/env bash
# next_graphql introspection SETUP: the inspectable state is the baseline itself — next_graphql is
# not enabled and its dependency graphql_compose is not installed. This module ships no code/config,
# so setup only asserts/echoes that baseline (no mutation). Idempotent.
set -uo pipefail
cd /var/www/html
en=$(drush php:eval 'print \Drupal::moduleHandler()->moduleExists("next_graphql") ? "yes" : "no";' 2>/dev/null)
gc=$(drush php:eval 'print \Drupal::service("extension.list.module")->exists("graphql_compose") ? "yes" : "no";' 2>/dev/null)
echo "setup: next_graphql_enabled=$en graphql_compose_present=$gc (baseline, no mutation)"
