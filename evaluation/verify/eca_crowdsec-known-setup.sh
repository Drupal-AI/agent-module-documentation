#!/usr/bin/env bash
# Introspection SETUP: create an ECA model (eca_crowdsec_known) whose event plugin is one of the
# eca_crowdsec derivatives, so an inspecting agent can read back which CrowdSec event it reacts to.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\eca\Entity\Eca;
  if (!Eca::load("eca_crowdsec_known")) {
    Eca::create([
      "id" => "eca_crowdsec_known", "label" => "eca_crowdsec known model",
      "modeller" => "fallback", "status" => TRUE, "version" => "1.0.0",
      "events" => ["e1" => ["plugin" => "crowdsec:signalled", "label" => "On IP signalled", "configuration" => [], "successors" => []]],
      "conditions" => [], "gateways" => [], "actions" => [],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: eca model eca_crowdsec_known reacts to crowdsec:signalled"
