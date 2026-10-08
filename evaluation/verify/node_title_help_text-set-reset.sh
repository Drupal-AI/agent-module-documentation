#!/usr/bin/env bash
# Execution RESET: ensure content type nthht_task exists with NO node_title_help_text
# title_help, so verify FAILS until the agent sets the requested text. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  $t = NodeType::load("nthht_task") ?: NodeType::create(["type"=>"nthht_task","name"=>"NTHHT Task"]);
  $t->save();
  if ($t->getThirdPartySetting("node_title_help_text","title_help")) {
    $t->unsetThirdPartySetting("node_title_help_text","title_help"); $t->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: nthht_task present, no title_help"
