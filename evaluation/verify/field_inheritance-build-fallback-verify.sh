#!/usr/bin/env bash
# PASS when an inheritance (id contains fi_fb) uses type=fallback, source node/article body,
# destination node/page. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field_inheritance\Entity\FieldInheritance;
  $m = NULL;
  foreach (FieldInheritance::loadMultiple() as $e) {
    if (strpos($e->id(),"fi_fb")!==FALSE && $e->type()==="fallback"
      && $e->sourceEntityType()==="node" && $e->sourceField()==="body"
      && $e->destinationEntityType()==="node" && $e->destinationEntityBundle()==="page") { $m=$e; break; }
  }
  print ($m ? "PASS id=".$m->id() : "FAIL no-match")."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
