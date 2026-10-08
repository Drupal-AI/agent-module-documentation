#!/usr/bin/env bash
# Introspection CLEANUP: delete the two media items and their files created by the setup.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("media");
  foreach (["LM Visible Asset", "LM Hidden Asset"] as $name) {
    foreach ($storage->loadByProperties(["name" => $name]) as $m) { $m->delete(); }
  }
  foreach (["public://lm-eval/lm-visible.txt", "public://lm-eval/lm-hidden.txt"] as $uri) {
    foreach (\Drupal::entityTypeManager()->getStorage("file")->loadByProperties(["uri" => $uri]) as $f) { $f->delete(); }
  }
' >/dev/null 2>&1
echo "cleanup: LM Visible Asset / LM Hidden Asset media and files removed"
