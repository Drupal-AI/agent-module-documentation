#!/usr/bin/env bash
# Execution CLEANUP: delete the probe article and uninstall typed_entity_example (baseline).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title","TE Article Probe")->execute();
  foreach (\Drupal\node\Entity\Node::loadMultiple($ids) as $n) { $n->delete(); }
' >/dev/null 2>&1
drush pmu typed_entity_example -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: probe article deleted; typed_entity_example uninstalled"
