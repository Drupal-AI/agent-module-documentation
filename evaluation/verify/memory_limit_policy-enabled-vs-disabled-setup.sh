#!/usr/bin/env bash
# Introspection SETUP: create two policies, mlp_active (status TRUE, 256M) and mlp_inactive
# (status FALSE, 999M), so the agent can state which one is evaluated. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
$s = \Drupal::entityTypeManager()->getStorage("memory_limit_policy");
foreach (["mlp_active","mlp_inactive"] as $id) { if ($e=$s->load($id)) { $e->delete(); } }
$s->create(["id"=>"mlp_active","label"=>"MLP active","memory"=>"256M","status"=>TRUE,"weight"=>0,"policy_constraints"=>[]])->save();
$s->create(["id"=>"mlp_inactive","label"=>"MLP inactive","memory"=>"999M","status"=>FALSE,"weight"=>0,"policy_constraints"=>[]])->save();
' >/dev/null 2>&1
echo "setup: mlp_active (enabled 256M) and mlp_inactive (disabled 999M) created"
