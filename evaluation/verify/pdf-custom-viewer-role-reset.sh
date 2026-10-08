#!/usr/bin/env bash
# Execution RESET for "themed pdf.js viewer + a role that may administer it".
# Deletes the pdf.settings config object (baseline: the module ships none) and removes the
# pdf_doc_manager role, so verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("pdf.settings")->delete();
  if ($r = \Drupal::entityTypeManager()->getStorage("user_role")->load("pdf_doc_manager")) { $r->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: pdf.settings deleted, role pdf_doc_manager removed"
