#!/usr/bin/env bash
# Reset for the form_options_attributes flat-select execution case.
# The agent's deliverable is a PHP file that RETURNS a select render array using
# #options_attributes. This reset deletes that file so each run starts from empty
# state (verify FAILs when the file is absent). No site config is touched — this
# API-only module has no persistent config surface, so reset is otherwise a no-op.
set -uo pipefail
TARGET="/var/www/html/web/sites/default/files/foa_eval_flat.php"
rm -f "$TARGET"
echo "reset: removed $TARGET (clean/empty state)"
