#!/usr/bin/env bash
# Introspection SETUP: create a content_moderation workflow vmsw_probe2 with a state 'vmsw_hold'
# weighted 23, recorded by the module in views_moderation_state_weights. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\workflows\Entity\Workflow;
  if (!Workflow::load("vmsw_probe2")) {
    $w = Workflow::create(["id"=>"vmsw_probe2","label"=>"VMSW Probe 2","type"=>"content_moderation"]);
    $tp = $w->getTypePlugin();
    $tp->addState("vmsw_hold","VMSW Hold");
    $conf = $tp->getConfiguration();
    $conf["states"]["vmsw_hold"]["weight"] = 23;
    $conf["states"]["vmsw_hold"]["published"] = FALSE;
    $conf["states"]["vmsw_hold"]["default_revision"] = FALSE;
    $tp->setConfiguration($conf);
    $w->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: workflow vmsw_probe2, state vmsw_hold weight 23"
