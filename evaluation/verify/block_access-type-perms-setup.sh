#!/usr/bin/env bash
# Introspection SETUP: create block content type ba_promo so block_access generates its
# per-type permissions dynamically. Agent inspects the live permission list. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block_content\Entity\BlockContentType;
  if (!BlockContentType::load("ba_promo")) {
    BlockContentType::create(["id" => "ba_promo", "label" => "BA Promo"])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block content type ba_promo created"
