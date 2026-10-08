#!/usr/bin/env bash
# Execution RESET: ensure translator tdeepl_ftask exists (plugin deepl_free) with formality
# "default", so verify FAILS until the agent changes it to a formal setting. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\tmgmt\Entity\Translator;
  $t = Translator::load("tdeepl_ftask");
  if (!$t) {
    $t = Translator::create(["name"=>"tdeepl_ftask","label"=>"Formality Task DeepL","plugin"=>"deepl_free","remote_languages_mappings"=>[]]);
  }
  $s = $t->getSettings();
  $s["auth_key"] = "PLACEHOLDER";
  $s["formality"] = "default";
  $t->setSettings($s);
  $t->save();
' >/dev/null 2>&1
echo "reset: tdeepl_ftask present with formality=default"
