#!/usr/bin/env bash
# Introspection CLEANUP: delete dp_intro's domain-specific aliases and the domain. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\domain\Entity\Domain;
  foreach (\Drupal::entityTypeManager()->getStorage("path_alias")->loadByProperties(["domain_id"=>"dp_intro"]) as $pa) { $pa->delete(); }
  if ($d = Domain::load("dp_intro")) { $d->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: dp_intro aliases + domain removed"
