#!/usr/bin/env bash
# Introspection SETUP: create the workbench_moderation_actions bulk action that sets nodes to the
# 'archived' moderation state (an 'action' config entity using the state_change:node__archived
# derivative), so an agent can inspect which state each state_change action targets. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Action;
  if (!Action::load("state_change__node__archived")) {
    Action::create([
      "id" => "state_change__node__archived", "label" => "Set Content as Archived",
      "type" => "node", "plugin" => "state_change:node__archived", "configuration" => [],
    ])->save();
  }
' >/dev/null 2>&1
echo "setup: action state_change__node__archived (plugin state_change:node__archived) exists"
