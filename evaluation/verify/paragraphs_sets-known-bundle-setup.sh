#!/usr/bin/env bash
# Introspection SETUP: create a known paragraphs_set (id ps_probe) containing one bp_callout
# paragraph so an agent can read the bundle back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\paragraphs_sets\Entity\ParagraphsSet;
  if ($s = ParagraphsSet::load("ps_probe")) { $s->delete(); }
  ParagraphsSet::create(["id"=>"ps_probe","label"=>"Probe Set","paragraphs"=>[["bundle"=>"bp_callout","data"=>[]]]])->save();
' >/dev/null 2>&1
echo "setup: paragraphs_set ps_probe (contains bp_callout)"
