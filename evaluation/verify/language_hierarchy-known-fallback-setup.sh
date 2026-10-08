#!/usr/bin/env bash
# Introspection SETUP: create languages lhp and lhc, and configure lhc to fall back to lhp via
# language_hierarchy, so an agent can read the fallback from live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\language\Entity\ConfigurableLanguage;
  foreach (["lhp" => "LH Parent", "lhc" => "LH Child"] as $lc => $name) {
    if (!ConfigurableLanguage::load($lc)) { ConfigurableLanguage::create(["id" => $lc, "label" => $name])->save(); }
  }
  $lhc = ConfigurableLanguage::load("lhc");
  $lhc->setThirdPartySetting("language_hierarchy", "fallback_langcode", "lhp");
  $lhc->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: lhc falls back to lhp"
