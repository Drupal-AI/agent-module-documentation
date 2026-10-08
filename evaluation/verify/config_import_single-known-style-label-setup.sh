#!/usr/bin/env bash
# Introspection SETUP: create image style cis_seed_a (label 'CIS Seed Alpha') via the config API,
# so an agent can inspect live config and read the label back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\image\Entity\ImageStyle;
  if (!ImageStyle::load("cis_seed_a")) {
    ImageStyle::create(["name" => "cis_seed_a", "label" => "CIS Seed Alpha"])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: image.style.cis_seed_a present (label 'CIS Seed Alpha')"
