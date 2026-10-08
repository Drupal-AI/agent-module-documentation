#!/usr/bin/env bash
# Introspection SETUP: create a DISABLED reaction rule rer_event that reacts to the Role Expire
# event role_expire_event_role_expires and runs a remove-expire action, so an agent can read which
# event triggers it. status FALSE. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\rules\Context\ContextConfig;
  $s = \Drupal::entityTypeManager()->getStorage("rules_reaction_rule");
  if ($e = $s->load("rer_event")) { $e->delete(); }
  $em = \Drupal::service("plugin.manager.rules_expression");
  $rule = $em->createRule();
  $rule->addExpressionObject($em->createAction("role_expire_remove_expire_time", ContextConfig::create()
    ->map("user", "account")->setValue("roles", ["authenticated"])));
  $s->create(["id" => "rer_event", "label" => "RER Event", "status" => FALSE,
    "events" => [["event_name" => "role_expire_event_role_expires"]], "expression" => $rule->getConfiguration()])->save();
' >/dev/null 2>&1
echo "setup: rules.reaction.rer_event reacts to role_expire_event_role_expires (disabled)"
