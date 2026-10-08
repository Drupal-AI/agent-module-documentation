#!/usr/bin/env bash
# Execution RESET: ensure languages lhp and lhc exist and force lhc's fallback_langcode EMPTY,
# so verify (expecting lhc -> lhp) FAILS until the agent sets it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\language\Entity\ConfigurableLanguage;
  foreach (["lhp" => "LH Parent", "lhc" => "LH Child"] as $lc => $name) {
    if (!ConfigurableLanguage::load($lc)) { ConfigurableLanguage::create(["id" => $lc, "label" => $name])->save(); }
  }
  $lhc = ConfigurableLanguage::load("lhc");
  $lhc->setThirdPartySetting("language_hierarchy", "fallback_langcode", "");
  $lhc->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: lhp, lhc present; lhc fallback cleared"
