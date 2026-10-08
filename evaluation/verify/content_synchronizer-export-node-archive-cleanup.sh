#!/usr/bin/env bash
# Execution CLEANUP: remove the output dir and the 'CS Export Task Node' node. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -rf /tmp/cs_export_out
drush php:eval '
  use Drupal\node\Entity\Node;
  foreach (\Drupal::entityQuery("node")->condition("title","CS Export Task Node")->accessCheck(FALSE)->execute() as $nid) { Node::load($nid)->delete(); }
' >/dev/null 2>&1
echo "cleanup: /tmp/cs_export_out and 'CS Export Task Node' removed"
