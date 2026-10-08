#!/usr/bin/env bash
# Introspection CLEANUP: delete embedded_content button 'ec_known'. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\embedded_content\Entity\EmbeddedContentButton;
  if ($e = EmbeddedContentButton::load("ec_known")) { $e->delete(); }
' >/dev/null 2>&1
echo "cleanup: removed embedded_content.button.ec_known"
