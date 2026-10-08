#!/usr/bin/env bash
# Execution CLEANUP: delete gutenberg_task and clear its gutenberg.settings key. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if ($t = NodeType::load("gutenberg_task")) { $t->delete(); }
  \Drupal::configFactory()->getEditable("gutenberg.settings")->clear("gutenberg_task_enable_full")->save();
' >/dev/null 2>&1
echo "cleanup: gutenberg_task removed and its gutenberg.settings key cleared"
