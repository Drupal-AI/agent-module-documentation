#!/usr/bin/env bash
# Execution CLEANUP: delete gutenberg_lock and clear its gutenberg.settings keys. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if ($t = NodeType::load("gutenberg_lock")) { $t->delete(); }
  $c = \Drupal::configFactory()->getEditable("gutenberg.settings");
  $c->clear("gutenberg_lock_enable_full")->clear("gutenberg_lock_template_lock")->save();
' >/dev/null 2>&1
echo "cleanup: gutenberg_lock removed and its gutenberg.settings keys cleared"
