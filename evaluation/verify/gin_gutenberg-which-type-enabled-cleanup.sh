#!/usr/bin/env bash
# Cleanup: clear article_enable_full; delete gutenberg.settings if it becomes empty. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("gutenberg.settings");
  $c->clear("article_enable_full");
  $raw = $c->getRawData();
  if (empty($raw)) { $c->delete(); } else { $c->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: article_enable_full cleared"
