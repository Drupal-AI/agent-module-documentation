#!/usr/bin/env bash
# Introspection SETUP: create a DISABLED reaction rule rer_eval with a role_expire_set_expire_time
# action whose date is '2031-06-15 12:00:00', so an agent can read the date back. status FALSE so
# it never executes. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\rules\Context\ContextConfig;
  $s = \Drupal::entityTypeManager()->getStorage("rules_reaction_rule");
  if ($e = $s->load("rer_eval")) { $e->delete(); }
  $em = \Drupal::service("plugin.manager.rules_expression");
  $rule = $em->createRule();
  $rule->addExpressionObject($em->createAction("role_expire_set_expire_time", ContextConfig::create()
    ->map("user", "user")->setValue("roles", ["authenticated"])->setValue("date", "2031-06-15 12:00:00")));
  $s->create(["id" => "rer_eval", "label" => "RER Eval", "status" => FALSE,
    "events" => [["event_name" => "rules_user_login"]], "expression" => $rule->getConfiguration()])->save();
' >/dev/null 2>&1
echo "setup: rules.reaction.rer_eval set-expire action date=2031-06-15 12:00:00 (disabled)"
