#!/usr/bin/env bash
# next_jsonapi execution VERIFY (uninstall case): PASS when next_jsonapi is NOT enabled and
# jsonapi.entity_resource has reverted to core Drupal\jsonapi\Controller\EntityResource, while jsonapi
# and next remain enabled. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $nj = \Drupal::moduleHandler()->moduleExists("next_jsonapi");
  $jsonapi = \Drupal::moduleHandler()->moduleExists("jsonapi");
  $next = \Drupal::moduleHandler()->moduleExists("next");
  $class = \Drupal::hasService("jsonapi.entity_resource") ? get_class(\Drupal::service("jsonapi.entity_resource")) : "none";
  $ok = (!$nj) && $jsonapi && $next && ($class === "Drupal\\jsonapi\\Controller\\EntityResource");
  print ($ok ? "PASS" : "FAIL") . " next_jsonapi=" . var_export($nj, TRUE) . " class=" . $class . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
