#!/usr/bin/env bash
# Introspection SETUP: create a TMGMT Translator (provider) that uses the google_v3 plugin with a
# known project id and location, so an inspecting agent can read them back. No live API call.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\tmgmt\Entity\Translator;
  if (!Translator::load("tmgmtg_probe")) {
    Translator::create([
      "name" => "tmgmtg_probe",
      "label" => "TMGMTG Probe Provider",
      "plugin" => "google_v3",
      "settings" => [
        "location" => "us-central1",
        "api_project" => "tmgmtg-probe-project",
        "glossary_mappings" => [],
      ],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: tmgmt.translator.tmgmtg_probe plugin=google_v3 api_project=tmgmtg-probe-project location=us-central1"
