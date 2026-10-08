#!/usr/bin/env bash
# Introspection SETUP: create a TMGMT DeepL translator provider tdeepl_known (plugin deepl_free)
# with formality "prefer_more" so an inspecting agent can read the provider and its settings.
# Uses a placeholder auth key (no API call happens just to save config). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\tmgmt\Entity\Translator;
  if (!Translator::load("tdeepl_known")) {
    Translator::create([
      "name" => "tdeepl_known", "label" => "Known DeepL",
      "plugin" => "deepl_free",
      "settings" => ["auth_key" => "PLACEHOLDER", "formality" => "prefer_more", "auto_accept" => TRUE],
      "remote_languages_mappings" => [],
    ])->save();
  }
' >/dev/null 2>&1
echo "setup: tmgmt.translator.tdeepl_known (plugin deepl_free, formality prefer_more)"
