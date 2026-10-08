#!/usr/bin/env bash
# Introspection SETUP: create an AWS profile aws_eval_profile (region us-west-2, marked default) so
# an agent can read its configured region. No AWS calls. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("aws_profile");
  if (!$s->load("aws_eval_profile")) {
    $s->create([
      "id" => "aws_eval_profile", "name" => "AWS Eval Profile", "default" => 1,
      "region" => "us-west-2", "aws_access_key_id" => "AKIAEVALEXAMPLE",
      "aws_secret_access_key" => "", "encryption_profile" => "_none",
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: aws_profile aws_eval_profile region=us-west-2 default=1"
