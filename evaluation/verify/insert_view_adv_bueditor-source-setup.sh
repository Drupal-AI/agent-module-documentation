#!/usr/bin/env bash
# Introspection SETUP (insert_view_adv_bueditor): this submodule declares core ^8||^9||^10 (no
# D11) and cannot be enabled on this Drupal 11 site, and bueditor cannot be installed here either
# (the shared site's contrib 'plugin' module fatals on every route rebuild during module install).
# There is therefore no runtime config to seed; the agent must inspect the submodule's on-disk
# SOURCE. This setup just confirms that source is present so the case is answerable. Exit 0.
set -uo pipefail
cd /var/www/html
f="web/modules/contrib/insert_view_adv/modules/bueditor/src/Plugin/BUEditorPlugin/DrupalViews.php"
if grep -q 'id = "drupalviews"' "$f" 2>/dev/null; then
  echo "setup: insert_view_adv_bueditor source present ($f defines BUEditorPlugin id drupalviews)"
else
  echo "setup: WARNING source not found at $f"
fi
