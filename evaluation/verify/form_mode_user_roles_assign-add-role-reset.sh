#!/usr/bin/env bash
# Execution RESET: seed user_team mode with ONE role (fmra_team_a) so the agent must ADD a second
# (fmra_team_b) without losing the first. verify (both present) FAILS on this single-role state. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("form_mode_user_roles_assign.settings")->set("form_modes.user_team.assign_roles",["fmra_team_a"=>"fmra_team_a"])->save();' >/dev/null 2>&1
echo "reset: form_modes.user_team.assign_roles = [fmra_team_a]"
