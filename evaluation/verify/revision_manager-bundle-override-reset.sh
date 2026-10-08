#!/usr/bin/env bash
# Execution RESET: remove any revision_manager third-party setting from node.type.article so
# verify FAILs until the agent adds the bundle override. Also enable node globally (a realistic
# precondition for bundle overrides). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  $c = \Drupal::configFactory()->getEditable("revision_manager.settings");
  $c->set("enabled_entities", ["node" => TRUE])->save();
  if ($nt = NodeType::load("article")) {
    $nt->unsetThirdPartySetting("revision_manager", "amount");
    $nt->unsetThirdPartySetting("revision_manager", "age");
    $nt->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.type.article has no revision_manager override; node enabled"
