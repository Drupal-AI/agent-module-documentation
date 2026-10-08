#!/usr/bin/env bash
# Introspection SETUP: create Context 'cadl_eval' with a context_advanced_datalayer reaction
# setting the 'event' datalayer tag to a distinctive value. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\context\Entity\Context;
  if ($e = Context::load("cadl_eval")) { $e->delete(); }
  $c = Context::create(["name"=>"cadl_eval","label"=>"CADL Eval"]);
  $c->save();
  $c->addReaction(["id"=>"context_advanced_datalayer","event"=>"ctxview"]);
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: context.context.cadl_eval reactions.context_advanced_datalayer.event = ctxview"
