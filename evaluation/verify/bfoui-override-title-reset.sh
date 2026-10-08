#!/usr/bin/env bash
# Execution RESET: ensure NO base field override exists on Article Title, so verify FAILS until
# the agent creates one labelled 'Article Headline'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Field\Entity\BaseFieldOverride;
  if ($o = BaseFieldOverride::load("node.article.title")) { $o->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article.title has no base field override"
