#!/usr/bin/env bash
# Introspection SETUP: create a content_moderation workflow vmsw_probe with a custom state
# 'vmsw_review' weighted 42; the module's workflow_insert hook records it in the
# views_moderation_state_weights table so an agent can read the weight back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\workflows\Entity\Workflow;
  if (!Workflow::load("vmsw_probe")) {
    $w = Workflow::create(["id"=>"vmsw_probe","label"=>"VMSW Probe","type"=>"content_moderation"]);
    $tp = $w->getTypePlugin();
    $tp->addState("vmsw_review","VMSW Review");
    $conf = $tp->getConfiguration();
    $conf["states"]["vmsw_review"]["weight"] = 42;
    $conf["states"]["vmsw_review"]["published"] = FALSE;
    $conf["states"]["vmsw_review"]["default_revision"] = FALSE;
    $tp->setConfiguration($conf);
    $w->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: workflow vmsw_probe, state vmsw_review weight 42"
