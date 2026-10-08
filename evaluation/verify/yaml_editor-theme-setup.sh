#!/usr/bin/env bash
# MEDIUM introspection setup: put a known, non-default Ace theme into yaml_editor.config
# so the agent must read the live site to answer which theme is configured.
set -uo pipefail
cd /var/www/html
drush cset -y yaml_editor.config editor_theme ace/theme/monokai >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: yaml_editor.config editor_theme = ace/theme/monokai"
