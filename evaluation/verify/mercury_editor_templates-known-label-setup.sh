#!/usr/bin/env bash
# Introspection SETUP: enable submodule and create one me_template labeled 'ME Known Template'.
set -uo pipefail
cd /var/www/html
drush en mercury_editor_templates -y >/dev/null 2>&1
drush php:eval '  $s = \Drupal::entityTypeManager()->getStorage("me_template");
  foreach ($s->loadByProperties(["label" => "ME Known Template"]) as $e) { $e->delete(); }
  \Drupal::entityTypeManager()->getStorage("me_template")->create(["label" => "ME Known Template", "status" => 1])->save();
' >/dev/null 2>&1
echo "setup: me_template 'ME Known Template' created"
