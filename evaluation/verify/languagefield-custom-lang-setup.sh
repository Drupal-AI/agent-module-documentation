#!/usr/bin/env bash
# Introspection SETUP: create a languagefield custom_language config entity lf_klingon with a
# known native name, so an inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("custom_language");
  if (!$s->load("lf_klingon")) {
    $s->create(["id" => "lf_klingon", "label" => "Klingon", "native_name" => "tlhIngan Hol", "direction" => "ltr", "weight" => 0])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: custom_language.lf_klingon created (native_name tlhIngan Hol)"
