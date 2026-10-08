#!/usr/bin/env bash
# Execution CLEANUP: remove the revision_manager override from node.type.article and restore
# revision_manager.settings to shipped defaults. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if ($nt = NodeType::load("article")) {
    $nt->unsetThirdPartySetting("revision_manager", "amount");
    $nt->unsetThirdPartySetting("revision_manager", "age");
    $nt->save();
  }
  $c = \Drupal::configFactory()->getEditable("revision_manager.settings");
  $c->set("enabled_entities", [])->set("defaults", [])
    ->set("disable_automatic_queueing", FALSE)->set("verbose_log", FALSE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node.type.article override removed; settings restored"
