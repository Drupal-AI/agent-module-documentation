#!/usr/bin/env bash
# Introspection SETUP: create a redirect with source 'rm-known-src' and set its
# redirect_metrics access_count to a known value (42) plus a last_access timestamp, so an
# inspecting agent can read the count back off the live redirect entity. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\redirect\Entity\Redirect;
  $found = NULL;
  foreach (Redirect::loadMultiple() as $r) {
    if ($r->getSource()["path"] === "rm-known-src") { $found = $r; break; }
  }
  if (!$found) {
    $found = Redirect::create();
    $found->setSource("rm-known-src");
    $found->setRedirect("/node");
    $found->setStatusCode(301);
  }
  $found->access_count->value = 42;
  $found->last_access->value = 1700000000;
  $found->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: redirect rm-known-src has access_count=42"
