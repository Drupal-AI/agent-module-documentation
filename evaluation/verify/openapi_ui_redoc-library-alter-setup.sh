#!/usr/bin/env bash
# Introspection SETUP: install a throwaway module that implements hook_library_info_alter()
# and repoints the openapi_ui_redoc/redoc library's JavaScript at a known pinned URL (instead
# of the module's default https://rebilly.github.io/ReDoc/releases/latest/redoc.min.js).
# The agent must read the LIVE library definition to find it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
M=web/modules/custom/oui_redoc_fx_lib
mkdir -p "$M"
cat > "$M/oui_redoc_fx_lib.info.yml" <<'YML'
name: 'OUI ReDoc fixture (library)'
type: module
description: 'Eval fixture: repoints the openapi_ui_redoc/redoc library JS.'
core_version_requirement: ^10 || ^11
package: Testing
dependencies:
  - openapi_ui_redoc:openapi_ui_redoc
YML
cat > "$M/oui_redoc_fx_lib.module" <<'PHP'
<?php

/**
 * @file
 * Eval fixture.
 */

/**
 * Implements hook_library_info_alter().
 */
function oui_redoc_fx_lib_library_info_alter(array &$libraries, $extension): void {
  if ($extension !== 'openapi_ui_redoc' || empty($libraries['redoc']['js'])) {
    return;
  }
  $libraries['redoc']['js'] = [
    'https://cdn.example.test/redoc-pinned-9-8-7.min.js' => [
      'type' => 'external',
      'minified' => TRUE,
    ],
  ];
}
PHP
drush en oui_redoc_fx_lib -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: openapi_ui_redoc/redoc library JS repointed to https://cdn.example.test/redoc-pinned-9-8-7.min.js"
