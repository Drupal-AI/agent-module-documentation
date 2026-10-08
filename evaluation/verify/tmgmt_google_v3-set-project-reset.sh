#!/usr/bin/env bash
# Execution RESET: ensure a google_v3 translator tmgmtg_cfg exists but with an EMPTY api_project
# (and default location), so verify FAILS until the agent sets the Google Cloud project id.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\tmgmt\Entity\Translator;
  $t = Translator::load("tmgmtg_cfg");
  if (!$t) {
    $t = Translator::create(["name" => "tmgmtg_cfg", "label" => "TMGMTG Cfg Provider", "plugin" => "google_v3"]);
  }
  $t->setSetting("location", "global");
  $t->setSetting("api_project", "");
  $t->setSetting("glossary_mappings", []);
  $t->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: tmgmtg_cfg present, api_project empty"
