#!/usr/bin/env bash
# Execution CLEANUP: delete the slideshow block and the two Document media fixtures.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("block_content")->loadByProperties(["info" => "LM Slideshow Task"]) as $b) { $b->delete(); }
  foreach (["LM Slide A", "LM Slide B"] as $name) {
    foreach (\Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name" => $name]) as $m) { $m->delete(); }
  }
  foreach (["public://lm-eval/lm-slide-a.txt", "public://lm-eval/lm-slide-b.txt"] as $uri) {
    foreach (\Drupal::entityTypeManager()->getStorage("file")->loadByProperties(["uri" => $uri]) as $f) { $f->delete(); }
  }
' >/dev/null 2>&1
echo "cleanup: 'LM Slideshow Task' block and slide fixtures removed"
