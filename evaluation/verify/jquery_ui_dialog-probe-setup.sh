#!/usr/bin/env bash
# Introspection SETUP (shared by the two jquery_ui_dialog medium cases): install a small custom
# module `jqd_probe` into web/modules/custom that (a) declares an asset library
# `jqd_probe/probe_dialog` depending on `jquery_ui_dialog/dialog` and (b) implements
# hook_library_info_alter() to stamp the dialog library's version as "1.13.2-probe9".
# Both facts are only discoverable by introspecting the running site's library registry.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
M=web/modules/custom/jqd_probe
mkdir -p "$M/js"
cat > "$M/jqd_probe.info.yml" <<'EOF'
name: 'jQuery UI Dialog probe'
type: module
description: 'Eval fixture: declares a library that depends on jquery_ui_dialog/dialog.'
core_version_requirement: ^10 || ^11
package: Testing
dependencies:
  - jquery_ui_dialog:jquery_ui_dialog
EOF
cat > "$M/jqd_probe.libraries.yml" <<'EOF'
probe_dialog:
  version: 1.x
  js:
    js/probe.js: {}
  dependencies:
    - jquery_ui_dialog/dialog
EOF
cat > "$M/js/probe.js" <<'EOF'
(function ($) { 'use strict'; }(jQuery));
EOF
cat > "$M/jqd_probe.module" <<'EOF'
<?php

/**
 * @file
 * Eval fixture for jquery_ui_dialog introspection cases.
 */

/**
 * Implements hook_library_info_alter().
 */
function jqd_probe_library_info_alter(array &$libraries, string $extension): void {
  if ($extension === 'jquery_ui_dialog' && isset($libraries['dialog'])) {
    $libraries['dialog']['version'] = '1.13.2-probe9';
  }
}
EOF
drush en jqd_probe -y >/dev/null 2>&1
# jquery_ui declares the dialog library via its own hook_library_info_alter(), so this fixture
# must run AFTER it for the version override to stick.
drush php:eval 'module_set_weight("jqd_probe", 50);' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: jqd_probe enabled (library jqd_probe/probe_dialog depends on jquery_ui_dialog/dialog; dialog version altered to 1.13.2-probe9)"
