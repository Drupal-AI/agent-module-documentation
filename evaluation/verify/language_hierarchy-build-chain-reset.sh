#!/usr/bin/env bash
# Execution RESET: ensure lhp, lhm, lhc exist with all their language_hierarchy fallbacks
# CLEARED, so verify (expecting lhc -> lhm -> lhp) FAILS until the agent builds the chain.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\language\Entity\ConfigurableLanguage;
  foreach (["lhp" => "LH Parent", "lhm" => "LH Middle", "lhc" => "LH Child"] as $lc => $name) {
    if (!ConfigurableLanguage::load($lc)) { ConfigurableLanguage::create(["id" => $lc, "label" => $name])->save(); }
    $l = ConfigurableLanguage::load($lc);
    $l->setThirdPartySetting("language_hierarchy", "fallback_langcode", "");
    $l->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: lhp, lhm, lhc present with cleared fallbacks"
