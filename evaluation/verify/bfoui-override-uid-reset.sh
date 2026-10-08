#!/usr/bin/env bash
# Execution RESET: ensure NO base field override exists on Article uid, so verify FAILS until
# the agent creates one labelled 'Author Account'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Field\Entity\BaseFieldOverride;
  if ($o = BaseFieldOverride::load("node.article.uid")) { $o->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article.uid has no base field override"
