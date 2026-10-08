#!/usr/bin/env bash
# Reset for the form_options_attributes optgroup-select execution case.
# Deletes the agent's deliverable file so each run starts from empty state
# (verify FAILs when absent). No site config to restore — API-only module.
set -uo pipefail
TARGET="/var/www/html/web/sites/default/files/foa_eval_group.php"
rm -f "$TARGET"
echo "reset: removed $TARGET (clean/empty state)"
