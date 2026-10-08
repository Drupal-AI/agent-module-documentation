#!/usr/bin/env bash
# Introspection SETUP: create a custom block content type (bundle) bct_probe so an agent can read
# its machine name and derive block_content_template's template-suggestion filename. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block_content\Entity\BlockContentType;
  if (!BlockContentType::load("bct_probe")) {
    BlockContentType::create(["id" => "bct_probe", "label" => "BCT Probe"])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block_content type bct_probe present"
