#!/usr/bin/env bash
# Execution CLEANUP: same as the reset — drop pdf.settings and the pdf_doc_manager role so
# the site is left at baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("pdf.settings")->delete();
  if ($r = \Drupal::entityTypeManager()->getStorage("user_role")->load("pdf_doc_manager")) { $r->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: pdf.settings deleted, role pdf_doc_manager removed"
