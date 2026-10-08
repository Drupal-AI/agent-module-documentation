#!/usr/bin/env bash
# Execution VERIFY for the obsolete-submodule audit.
# PASS when Drupal state key mdft_audit_lifecycle === "obsolete" (the lifecycle declared in
# manage_display_fix_title.info.yml) and mdft_audit_installed === "no" (the submodule is not
# installed, and cannot be on Drupal 11). Both values must match the site's real state, which
# this script re-derives independently via getAllAvailableInfo() (getExtensionInfo() throws for
# uninstalled modules). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $lifecycle = strtolower(trim((string) \Drupal::state()->get("mdft_audit_lifecycle", "")));
  $installed = strtolower(trim((string) \Drupal::state()->get("mdft_audit_installed", "")));
  $all = \Drupal::service("extension.list.module")->getAllAvailableInfo();
  $real_lifecycle = $all["manage_display_fix_title"]["lifecycle"] ?? "";
  $real_installed = \Drupal::moduleHandler()->moduleExists("manage_display_fix_title") ? "yes" : "no";
  $ok = ($lifecycle === $real_lifecycle) && ($lifecycle === "obsolete") && ($installed === $real_installed) && ($installed === "no");
  print ($ok ? "PASS" : "FAIL") . " reported_lifecycle=" . var_export($lifecycle, TRUE)
    . " reported_installed=" . var_export($installed, TRUE)
    . " actual_lifecycle=" . var_export($real_lifecycle, TRUE)
    . " actual_installed=" . var_export($real_installed, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
