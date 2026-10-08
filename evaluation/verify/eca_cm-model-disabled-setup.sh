#!/usr/bin/env bash
# Introspection SETUP: create an ECA model 'eca_cm_mod' that is DISABLED, so the agent must
# inspect the live config to report its status. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("eca");
  $e = $s->load("eca_cm_mod");
  if (!$e) {
    $e = $s->create(["id" => "eca_cm_mod", "label" => "CM Mod", "modeller" => "core",
      "events" => [], "conditions" => [], "actions" => [], "gateways" => [], "version" => "1.0.0"]);
  }
  $e->setStatus(FALSE)->save();
' >/dev/null 2>&1
echo "setup: eca.eca.eca_cm_mod created and DISABLED"
