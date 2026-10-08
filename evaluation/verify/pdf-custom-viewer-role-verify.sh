#!/usr/bin/env bash
# Execution VERIFY for "themed pdf.js viewer + a role that may administer it".
# PASS when pdf.settings.custom_viewer is exactly the requested themed viewer path AND a
# user role pdf_doc_manager exists holding the pdf module's `administer pdfjs` permission.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $viewer = \Drupal::config("pdf.settings")->get("custom_viewer");
  $role = \Drupal::entityTypeManager()->getStorage("user_role")->load("pdf_doc_manager");
  $has = $role ? $role->hasPermission("administer pdfjs") : FALSE;
  $ok = ($viewer === "/themes/custom/acme/pdfjs/viewer.html") && $has;
  print ($ok ? "PASS" : "FAIL")
    . " custom_viewer=" . var_export($viewer, TRUE)
    . " role=" . ($role ? "present" : "missing")
    . " administer_pdfjs=" . var_export($has, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
