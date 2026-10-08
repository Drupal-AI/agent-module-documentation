#!/usr/bin/env bash
# Introspection SETUP (shared by both medium cases): create + enable a helper module
# `mfe_intro` exposing a form (mfe_intro_form) that uses the `multivalue` element with two
# arbitrary, NON-documented configurations an inspecting agent must read off the live form:
#   - `teammates`: unlimited cardinality, custom #add_more_label "Add a teammate", child `name`.
#   - `skills`: #cardinality 3, two children `label` (textfield) + `level` (number).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
DIR=web/modules/custom/mfe_intro
mkdir -p "$DIR/src/Form"
cat > "$DIR/mfe_intro.info.yml" <<'YML'
name: 'MFE Intro'
type: module
description: 'Eval helper: form using the multivalue element (introspection).'
core_version_requirement: ^10 || ^11
dependencies:
  - drupal:multivalue_form_element
YML
cat > "$DIR/mfe_intro.routing.yml" <<'YML'
mfe_intro.form:
  path: '/mfe-intro'
  defaults:
    _title: 'MFE Intro'
    _form: '\Drupal\mfe_intro\Form\MfeIntroForm'
  requirements:
    _access: 'TRUE'
YML
cat > "$DIR/src/Form/MfeIntroForm.php" <<'PHP'
<?php
namespace Drupal\mfe_intro\Form;

use Drupal\Core\Form\FormBase;
use Drupal\Core\Form\FormStateInterface;
use Drupal\multivalue_form_element\Element\MultiValue;

class MfeIntroForm extends FormBase {
  public function getFormId() { return 'mfe_intro_form'; }
  public function buildForm(array $form, FormStateInterface $form_state) {
    $form['teammates'] = [
      '#type' => 'multivalue',
      '#title' => $this->t('Teammates'),
      '#cardinality' => MultiValue::CARDINALITY_UNLIMITED,
      '#add_more_label' => $this->t('Add a teammate'),
      'name' => ['#type' => 'textfield', '#title' => $this->t('Name')],
    ];
    $form['skills'] = [
      '#type' => 'multivalue',
      '#title' => $this->t('Skills'),
      '#cardinality' => 3,
      'label' => ['#type' => 'textfield', '#title' => $this->t('Label')],
      'level' => ['#type' => 'number', '#title' => $this->t('Level')],
    ];
    $form['actions']['#type'] = 'actions';
    $form['actions']['submit'] = ['#type' => 'submit', '#value' => $this->t('Save')];
    return $form;
  }
  public function submitForm(array &$form, FormStateInterface $form_state) {}
}
PHP
drush en mfe_intro -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: mfe_intro enabled (teammates add_more_label='Add a teammate'; skills cardinality 3, children label+level)"
