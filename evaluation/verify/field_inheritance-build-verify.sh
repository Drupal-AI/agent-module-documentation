#!/usr/bin/env bash
# Execution VERIFY: PASS when a field_inheritance entity exists (id containing 'fi_task') that
# inherits (type=inherit) the node/article 'body' field into the node/page bundle. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field_inheritance\Entity\FieldInheritance;
  $match = NULL;
  foreach (FieldInheritance::loadMultiple() as $e) {
    if (strpos($e->id(), "fi_task") !== FALSE
      && $e->type() === "inherit"
      && $e->sourceEntityType() === "node"
      && $e->sourceField() === "body"
      && $e->destinationEntityType() === "node"
      && $e->destinationEntityBundle() === "page") { $match = $e; break; }
  }
  print ($match ? "PASS id=".$match->id() : "FAIL no-match")."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
