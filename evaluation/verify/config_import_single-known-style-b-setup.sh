#!/usr/bin/env bash
# Introspection SETUP: create image style cis_seed_b (label 'CIS Seed Bravo'). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  if (!ImageStyle::load("cis_seed_b")) {
    ImageStyle::create(["name" => "cis_seed_b", "label" => "CIS Seed Bravo"])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: image.style.cis_seed_b present (label 'CIS Seed Bravo')"
