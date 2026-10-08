#!/usr/bin/env bash
# Execution RESET: ensure text format pee_exec exists WITHOUT the paragraphs_entity_embed filter,
# so verify FAILS until the agent enables it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("pee_exec");
  if (!$f) { $f = FilterFormat::create(["format" => "pee_exec", "name" => "PEE Exec"]); }
  $f->setFilterConfig("paragraphs_entity_embed", ["status" => FALSE]);
  $f->save();
' >/dev/null 2>&1
echo "reset: text format pee_exec present WITHOUT paragraphs_entity_embed filter"
