#!/usr/bin/env bash
# Introspection SETUP: create+enable the fixed helper module block_form_alter_probe which
# implements hook_block_plugin_form_alter() and injects a known marker for the
# system_powered_by_block plugin, so an agent can inspect the live hook implementation.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
M=web/modules/custom/block_form_alter_probe
mkdir -p "$M"
cat > "$M/block_form_alter_probe.info.yml" <<'YML'
name: 'Block Form Alter Probe (eval fixture)'
type: module
description: 'Eval fixture: implements hook_block_plugin_form_alter for block_form_alter introspection cases.'
core_version_requirement: ^10 || ^11
dependencies:
  - block_form_alter:block_form_alter
YML
cat > "$M/block_form_alter_probe.module" <<'PHP'
<?php

/**
 * @file
 * Eval fixture for block_form_alter introspection cases.
 */

/**
 * Implements hook_block_plugin_form_alter().
 */
function block_form_alter_probe_block_plugin_form_alter(array &$form, \Drupal\Core\Form\FormStateInterface &$form_state, string $plugin) {
  if ($plugin === 'system_powered_by_block') {
    $form['bfa_probe_marker'] = ['#value' => 'bfa-probe-plugin-777'];
  }
}
PHP
drush en block_form_alter_probe -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block_form_alter_probe enabled (marker bfa-probe-plugin-777 for system_powered_by_block)"
