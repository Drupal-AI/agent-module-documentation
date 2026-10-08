#!/usr/bin/env bash
# Introspection SETUP: create one enabled ckeditor_templates config entity restricted to the
# full_html text format, so an inspecting agent can read its id/label/format back out of
# ckeditor_templates.ckeditor_templates.*. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("ckeditor_templates");
  if ($existing = $storage->load("ckeditor_templates_promo")) { $existing->delete(); }
  $storage->create([
    "id" => "ckeditor_templates_promo",
    "label" => "Quarterly Promo Banner",
    "status" => TRUE,
    "description" => "Two-column promo banner with a call to action.",
    "thumb" => [],
    "thumb_alternative" => "",
    "code" => ["value" => "<div class=\"promo-banner-q4\"><h2>Promo</h2></div>", "format" => "full_html"],
    "formats" => ["full_html" => "full_html"],
    "weight" => 0,
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ckeditor_templates.ckeditor_templates.ckeditor_templates_promo created (full_html only)"
