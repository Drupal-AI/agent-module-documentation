#!/usr/bin/env bash
# Execution RESET: ensure no ECA model named eca_crowdsec_task exists, so verify FAILS until the agent
# builds one reacting to the CrowdSec "IP banned" event. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\eca\Entity\Eca;
  if ($e = Eca::load("eca_crowdsec_task")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: eca model eca_crowdsec_task absent"
