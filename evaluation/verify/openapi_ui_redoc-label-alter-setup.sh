#!/usr/bin/env bash
# Introspection SETUP: install a throwaway module that implements hook_openapi_ui_alter() and
# rewrites the LABEL of the `redoc` openapi_ui plugin definition to a known marker string.
# The agent must inspect the live openapi_ui plugin manager to read it back (the label in the
# module's own @OpenApiUi annotation is just "ReDoc"). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
M=web/modules/custom/oui_redoc_fx_label
mkdir -p "$M"
cat > "$M/oui_redoc_fx_label.info.yml" <<'YML'
name: 'OUI ReDoc fixture (label)'
type: module
description: 'Eval fixture: relabels the redoc openapi_ui plugin.'
core_version_requirement: ^10 || ^11
package: Testing
dependencies:
  - openapi_ui_redoc:openapi_ui_redoc
YML
cat > "$M/oui_redoc_fx_label.module" <<'PHP'
<?php

/**
 * @file
 * Eval fixture.
 */

/**
 * Implements hook_openapi_ui_alter().
 */
function oui_redoc_fx_label_openapi_ui_alter(array &$definitions): void {
  if (isset($definitions['redoc'])) {
    $definitions['redoc']['label'] = 'ReDoc Fixture Build 4711';
  }
}
PHP
drush en oui_redoc_fx_label -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: openapi_ui plugin 'redoc' label altered to 'ReDoc Fixture Build 4711'"
