#!/usr/bin/env bash
# Introspection SETUP: to channel 'ws_eval2', log a WS_EVAL_ALPHA message 2x and a
# WS_EVAL_BETA message 9x, so BETA is the more frequent grouped message. Clears prior ws_eval2
# rows first. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::database()->delete("watchdog")->condition("type", "ws_eval2")->execute();
  $logger = \Drupal::logger("ws_eval2");
  for ($i = 0; $i < 2; $i++) { $logger->notice("WS_EVAL_ALPHA alpha message"); }
  for ($i = 0; $i < 9; $i++) { $logger->warning("WS_EVAL_BETA beta message"); }
' >/dev/null 2>&1
echo "setup: ws_eval2 ALPHA=2, BETA=9"
