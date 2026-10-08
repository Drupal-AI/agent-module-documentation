#!/usr/bin/env bash
# Introspection SETUP: create the workbench_moderation_actions bulk action that sets CUSTOM BLOCK
# entities to the 'draft' state (state_change:block_content__draft derivative), so an agent can
# read which entity type + target state a given state_change action applies to. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Action;
  if (!Action::load("state_change__block_content__draft")) {
    Action::create([
      "id" => "state_change__block_content__draft", "label" => "Set Custom block as Draft",
      "type" => "block_content", "plugin" => "state_change:block_content__draft", "configuration" => [],
    ])->save();
  }
' >/dev/null 2>&1
echo "setup: action state_change__block_content__draft exists (type block_content)"
