#!/usr/bin/env bash
# Execution VERIFY: PASS when the S3 service override in aws.settings points at profile
# aws_svc_profile. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $cfg = \Drupal::config("aws.settings")->get("services") ?: [];
  $profile = $cfg["s3"]["profile"] ?? NULL;
  $ok = ($profile === "aws_svc_profile");
  print ($ok ? "PASS" : "FAIL") . " s3_profile=" . var_export($profile, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
