#!/usr/bin/env bash
# Introspection CLEANUP: delete ckemoji_on and ckemoji_off. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  foreach (["ckemoji_on","ckemoji_off"] as $id) {
    if ($e = \Drupal\editor\Entity\Editor::load($id)) { $e->delete(); }
    if ($f = \Drupal\filter\Entity\FilterFormat::load($id)) { $f->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ckemoji_on and ckemoji_off removed"
