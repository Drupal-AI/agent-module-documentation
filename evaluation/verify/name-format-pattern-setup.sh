#!/usr/bin/env bash
# Introspection SETUP: create a name_format config entity `name_probe` with a KNOWN pattern
# (`f, g` = family, comma-space, given) so an inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\name\Entity\NameFormat;
  if (!NameFormat::load("name_probe")) {
    NameFormat::create(["id" => "name_probe", "label" => "Name Probe", "pattern" => "f, g"])->save();
  } else {
    $e = NameFormat::load("name_probe"); $e->set("pattern", "f, g")->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: name.name_format.name_probe pattern=f, g"
