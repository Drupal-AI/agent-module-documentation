#!/usr/bin/env bash
# Introspection SETUP: create lhp, lhm, lhc and configure the chain lhc -> lhm -> lhp, so an
# agent can read/resolve the full fallback chain from the live site. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\language\Entity\ConfigurableLanguage;
  foreach (["lhp" => "LH Parent", "lhm" => "LH Middle", "lhc" => "LH Child"] as $lc => $name) {
    if (!ConfigurableLanguage::load($lc)) { ConfigurableLanguage::create(["id" => $lc, "label" => $name])->save(); }
  }
  $lhc = ConfigurableLanguage::load("lhc");
  $lhc->setThirdPartySetting("language_hierarchy", "fallback_langcode", "lhm"); $lhc->save();
  $lhm = ConfigurableLanguage::load("lhm");
  $lhm->setThirdPartySetting("language_hierarchy", "fallback_langcode", "lhp"); $lhm->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: chain lhc -> lhm -> lhp"
