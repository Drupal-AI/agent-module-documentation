#!/usr/bin/env bash
# Introspection SETUP: create a known paragraphs_set (id ps_named, label 'Landing Hero Set') so
# an agent can map label -> id. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\paragraphs_sets\Entity\ParagraphsSet;
  if ($s = ParagraphsSet::load("ps_named")) { $s->delete(); }
  ParagraphsSet::create(["id"=>"ps_named","label"=>"Landing Hero Set","paragraphs"=>[["bundle"=>"bp_simple","data"=>[]]]])->save();
' >/dev/null 2>&1
echo "setup: paragraphs_set ps_named (label 'Landing Hero Set')"
