#!/usr/bin/env bash
# Introspection SETUP: create a TMGMT DeepL translator provider tdeepl_kind using the PRO plugin
# (deepl_pro) so an inspecting agent can read whether it uses DeepL Free or Pro. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\tmgmt\Entity\Translator;
  if (!Translator::load("tdeepl_kind")) {
    Translator::create([
      "name" => "tdeepl_kind", "label" => "Kind DeepL",
      "plugin" => "deepl_pro",
      "settings" => ["auth_key" => "PLACEHOLDER"],
      "remote_languages_mappings" => [],
    ])->save();
  }
' >/dev/null 2>&1
echo "setup: tmgmt.translator.tdeepl_kind (plugin deepl_pro)"
