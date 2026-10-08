#!/usr/bin/env bash
# Introspection SETUP: set known DRD Agent State — Debug mode ON and an authorised dashboard
# entry keyed 'drdmed_dash' — so the agent can read them back. Baseline is unset. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::state();
  $s->set("drd_agent.debug_mode", TRUE);
  $s->set("drd_agent.authorised", ["drdmed_dash" => ["label" => "Medium Dashboard", "secret" => "x"]]);
' >/dev/null 2>&1
echo "setup: drd_agent.debug_mode=TRUE, drd_agent.authorised has key drdmed_dash"
