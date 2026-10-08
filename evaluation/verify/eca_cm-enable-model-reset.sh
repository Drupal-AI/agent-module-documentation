#!/usr/bin/env bash
# Execution RESET: create/ensure ECA model 'eca_cm_toggle' (modeller core) DISABLED,
# so verify (enabled) FAILS until the agent enables it. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("eca");
  $e = $s->load("eca_cm_toggle");
  if (!$e) {
    $e = $s->create(["id" => "eca_cm_toggle", "label" => "CM Toggle", "modeller" => "core",
      "events" => [], "conditions" => [], "actions" => [], "gateways" => [], "version" => "1.0.0"]);
  }
  $e->setStatus(FALSE)->save();
' >/dev/null 2>&1
echo "reset: eca_cm_toggle present and DISABLED"
