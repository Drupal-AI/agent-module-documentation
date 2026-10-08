#!/usr/bin/env bash
# Introspection CLEANUP: delete the namespaced content type and clear its gutenberg.settings keys.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if ($t = NodeType::load("gutenberg_probe")) { $t->delete(); }
  $c = \Drupal::configFactory()->getEditable("gutenberg.settings");
  $c->clear("gutenberg_probe_enable_full")->clear("gutenberg_probe_template_lock")->save();
' >/dev/null 2>&1
echo "cleanup: gutenberg_probe removed and its gutenberg.settings keys cleared"
