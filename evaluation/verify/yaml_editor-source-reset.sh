#!/usr/bin/env bash
# HARD execution reset: restore editor_source to the cdnjs default so the "self-host Ace"
# task starts from a known non-target state (verify must FAIL right after this runs).
set -uo pipefail
cd /var/www/html
drush cset -y yaml_editor.config editor_source '//cdnjs.cloudflare.com/ajax/libs/ace/1.2.0/ace.min.js' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: yaml_editor.config editor_source restored to cdnjs default"
