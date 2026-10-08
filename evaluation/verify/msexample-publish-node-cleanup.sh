#!/usr/bin/env bash
# Execution CLEANUP (message_subscribe_example): delete the test node + its publish_node messages, then
# uninstall the example submodule to restore the shared-site baseline. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (\Drupal::entityTypeManager()->hasDefinition("message")) {
    $mids = \Drupal::entityQuery("message")->condition("template", "publish_node")->accessCheck(FALSE)->execute();
    foreach (\Drupal\message\Entity\Message::loadMultiple($mids) as $m) { $m->delete(); }
  }
  $nids = \Drupal::entityQuery("node")->condition("title", "MS Example Task Node")->accessCheck(FALSE)->execute();
  foreach (\Drupal\node\Entity\Node::loadMultiple($nids) as $n) { $n->delete(); }
' >/dev/null 2>&1
drush -y pmu message_subscribe_example >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: removed test node + publish_node messages; example uninstalled (baseline)"
