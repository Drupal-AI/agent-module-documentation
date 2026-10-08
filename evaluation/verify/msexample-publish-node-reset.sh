#!/usr/bin/env bash
# Execution RESET (message_subscribe_example): enable the example submodule and clear prior state --
# delete any node titled 'MS Example Task Node' and any publish_node messages -- so verify FAILS
# until the agent creates a published article that triggers the example's node_insert. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush -y en message_subscribe_example >/dev/null 2>&1
drush php:eval '
  $nids = \Drupal::entityQuery("node")->condition("title", "MS Example Task Node")->accessCheck(FALSE)->execute();
  foreach (\Drupal\node\Entity\Node::loadMultiple($nids) as $n) { $n->delete(); }
  if (\Drupal::entityTypeManager()->hasDefinition("message")) {
    $mids = \Drupal::entityQuery("message")->condition("template", "publish_node")->accessCheck(FALSE)->execute();
    foreach (\Drupal\message\Entity\Message::loadMultiple($mids) as $m) { $m->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: example enabled; removed MS Example Task Node nodes and publish_node messages"
