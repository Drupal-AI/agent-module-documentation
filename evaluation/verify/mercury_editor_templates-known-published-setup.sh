#!/usr/bin/env bash
# Introspection SETUP: enable submodule and create a published + an unpublished template.
set -uo pipefail
cd /var/www/html
drush en mercury_editor_templates -y >/dev/null 2>&1
drush php:eval '  $s = \Drupal::entityTypeManager()->getStorage("me_template");
  foreach ($s->loadByProperties(["label" => "ME Pub Template"]) as $e) { $e->delete(); }  $s = \Drupal::entityTypeManager()->getStorage("me_template");
  foreach ($s->loadByProperties(["label" => "ME Draft Template"]) as $e) { $e->delete(); }
  $s = \Drupal::entityTypeManager()->getStorage("me_template");
  $s->create(["label" => "ME Pub Template", "status" => 1])->save();
  $s->create(["label" => "ME Draft Template", "status" => 0])->save();
' >/dev/null 2>&1
echo "setup: me_template 'ME Pub Template' (published) + 'ME Draft Template' (draft)"
