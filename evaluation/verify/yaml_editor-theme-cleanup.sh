#!/usr/bin/env bash
# MEDIUM introspection cleanup: restore editor_theme to its install/update-hook default.
set -uo pipefail
cd /var/www/html
drush cset -y yaml_editor.config editor_theme ace/theme/chrome >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: yaml_editor.config editor_theme restored to ace/theme/chrome"
