#!/usr/bin/env bash
# Execution RESET: ensure node 'CS Export Task Node' exists and clear the output directory
# /tmp/cs_export_out so verify FAILS until the agent produces an archive there. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
rm -rf /tmp/cs_export_out
drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->condition("title","CS Export Task Node")->accessCheck(FALSE)->execute();
  if (!$ids) { Node::create(["type"=>"article","title"=>"CS Export Task Node","status"=>1])->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node 'CS Export Task Node' present, /tmp/cs_export_out cleared"
