#!/usr/bin/env bash
# Execution RESET: enable typed_entity_example and delete any probe article so verify FAILS
# until one exists (and wraps as Article). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en typed_entity_example -y >/dev/null 2>&1
drush php:eval '
  foreach(\Drupal\node\Entity\Node::loadMultiple(\Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title","TEE Article Probe")->execute()) as $n){$n->delete();}
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: typed_entity_example enabled; no 'TEE Article Probe' article"
