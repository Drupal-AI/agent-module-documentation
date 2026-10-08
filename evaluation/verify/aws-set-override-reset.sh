#!/usr/bin/env bash
# Execution RESET: ensure profile aws_svc_profile exists and the S3 service has NO override, so
# verify FAILS until the agent binds S3 to that profile. No AWS calls. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("aws_profile");
  if (!$s->load("aws_svc_profile")) {
    $s->create([
      "id" => "aws_svc_profile", "name" => "AWS Svc Profile", "default" => 0,
      "region" => "us-east-1", "aws_secret_access_key" => "", "encryption_profile" => "_none",
    ])->save();
  }
  \Drupal::service("aws")->setServiceConfig("s3", NULL);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: aws_svc_profile exists, no S3 override"
