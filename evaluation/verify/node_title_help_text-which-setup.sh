#!/usr/bin/env bash
# Introspection SETUP: create two content types; nthht_on has node_title_help_text title_help
# set, nthht_off does not. Agent must inspect config to tell which one has title help.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  $on = NodeType::load("nthht_on") ?: NodeType::create(["type"=>"nthht_on","name"=>"NTHHT On"]);
  $on->save();
  $on->setThirdPartySetting("node_title_help_text","title_help","Give this landing page a campaign-specific title.");
  $on->save();
  $off = NodeType::load("nthht_off") ?: NodeType::create(["type"=>"nthht_off","name"=>"NTHHT Off"]);
  $off->save();
  if ($off->getThirdPartySetting("node_title_help_text","title_help")) {
    $off->unsetThirdPartySetting("node_title_help_text","title_help"); $off->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: nthht_on has title_help, nthht_off does not"
