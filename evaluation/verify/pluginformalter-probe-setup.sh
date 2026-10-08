#!/usr/bin/env bash
# Introspection SETUP: create+enable helper module pluginformalter_probe providing a
# @FormAlter plugin for form_id user_login_form that injects a known marker string, so an
# agent can inspect the live FormAlter plugin. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
M=web/modules/custom/pluginformalter_probe
mkdir -p "$M/src/Plugin/FormAlter"
cat > "$M/pluginformalter_probe.info.yml" <<'YML'
name: 'Plugin Form Alter Probe (eval fixture)'
type: module
description: 'Eval fixture: @FormAlter plugin for user_login_form used by pluginformalter introspection cases.'
core_version_requirement: ^10 || ^11
dependencies:
  - pluginformalter:pluginformalter
YML
cat > "$M/src/Plugin/FormAlter/ProbeLoginAlter.php" <<'PHP'
<?php

namespace Drupal\pluginformalter_probe\Plugin\FormAlter;

use Drupal\Core\Form\FormStateInterface;
use Drupal\pluginformalter\Plugin\FormAlterBase;

/**
 * @FormAlter(
 *   id = "pluginformalter_probe_login",
 *   label = @Translation("Probe login alter"),
 *   form_id = { "user_login_form" }
 * )
 */
class ProbeLoginAlter extends FormAlterBase {

  public function formAlter(array &$form, FormStateInterface $form_state, $form_id) {
    $form['pfa_probe_marker'] = ['#value' => 'pfa-probe-login-555'];
  }

}
PHP
drush en pluginformalter_probe -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: pluginformalter_probe enabled (@FormAlter user_login_form marker pfa-probe-login-555)"
