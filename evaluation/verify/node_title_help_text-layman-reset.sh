#!/usr/bin/env bash
# Execution RESET: ensure content type nthht_recipe exists with NO node_title_help_text
# title_help, so verify FAILS until the agent adds any title help text. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  $t = NodeType::load("nthht_recipe") ?: NodeType::create(["type"=>"nthht_recipe","name"=>"NTHHT Recipe"]);
  $t->save();
  if ($t->getThirdPartySetting("node_title_help_text","title_help")) {
    $t->unsetThirdPartySetting("node_title_help_text","title_help"); $t->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: nthht_recipe present, no title_help"
