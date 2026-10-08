#!/usr/bin/env bash
# Introspection SETUP: set llms_txt.settings.content to a known marker body so an agent can
# read the configured /llms.txt body back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("llms_txt.settings")
    ->set("content", "# LLMS_TXT_EVAL_MARKER\n\nMachine index for AI agents.\n")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: llms_txt.settings.content set to LLMS_TXT_EVAL_MARKER body"
