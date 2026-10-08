#!/usr/bin/env bash
# Execution CLEANUP: delete probe article and uninstall typed_entity_example. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach(\Drupal\node\Entity\Node::loadMultiple(\Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title","TEE Article Probe")->execute()) as $n){$n->delete();}
' >/dev/null 2>&1
drush pmu typed_entity_example -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: probe article deleted; typed_entity_example uninstalled"
