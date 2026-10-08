#!/usr/bin/env bash
# Introspection SETUP: create two redirects rm-pop-a (access_count 3) and rm-pop-b
# (access_count 500) so an agent can compare their redirect_metrics usage. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\redirect\Entity\Redirect;
  $want = ["rm-pop-a" => 3, "rm-pop-b" => 500];
  $seen = [];
  foreach (Redirect::loadMultiple() as $r) {
    $s = $r->getSource()["path"];
    if (isset($want[$s])) { $r->access_count->value = $want[$s]; $r->last_access->value = 1700000000; $r->save(); $seen[$s] = TRUE; }
  }
  foreach ($want as $src => $count) {
    if (empty($seen[$src])) {
      $r = Redirect::create();
      $r->setSource($src); $r->setRedirect("/node"); $r->setStatusCode(301);
      $r->access_count->value = $count; $r->last_access->value = 1700000000; $r->save();
    }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: rm-pop-a=3, rm-pop-b=500"
