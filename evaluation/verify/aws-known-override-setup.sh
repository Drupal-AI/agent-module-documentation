#!/usr/bin/env bash
# Introspection SETUP: create profile aws_svc_eval and bind the S3 service to it via a service
# override, so an agent can discover which profile S3 uses. No AWS calls. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("aws_profile");
  if (!$s->load("aws_svc_eval")) {
    $s->create([
      "id" => "aws_svc_eval", "name" => "AWS Svc Eval", "default" => 0,
      "region" => "eu-west-1", "aws_secret_access_key" => "", "encryption_profile" => "_none",
    ])->save();
  }
  \Drupal::service("aws")->setServiceConfig("s3", ["profile" => "aws_svc_eval", "version" => "latest"]);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: aws.settings services.s3 -> profile aws_svc_eval"
