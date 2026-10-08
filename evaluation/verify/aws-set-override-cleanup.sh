#!/usr/bin/env bash
# Execution CLEANUP: remove the S3 override and delete aws_svc_profile. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::service("aws")->setServiceConfig("s3", NULL);
  $s = \Drupal::entityTypeManager()->getStorage("aws_profile");
  if ($p = $s->load("aws_svc_profile")) { $p->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: s3 override + aws_svc_profile removed"
