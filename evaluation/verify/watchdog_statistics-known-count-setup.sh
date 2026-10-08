#!/usr/bin/env bash
# Introspection SETUP: log the same message 7 times to the 'ws_eval' channel so watchdog holds
# exactly 7 rows of type ws_eval for an agent to count. Clears any prior ws_eval rows first so
# the count is deterministic. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::database()->delete("watchdog")->condition("type", "ws_eval")->execute();
  $logger = \Drupal::logger("ws_eval");
  for ($i = 0; $i < 7; $i++) { $logger->notice("WS_EVAL_MARKER repeated message"); }
' >/dev/null 2>&1
echo "setup: 7 watchdog rows of type ws_eval"
