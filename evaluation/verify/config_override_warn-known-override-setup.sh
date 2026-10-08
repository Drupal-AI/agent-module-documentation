#!/usr/bin/env bash
# Introspection SETUP: install a tiny config.factory.override provider module
# (cow_eval_override) that overrides system.site:slogan, so config_override_warn has a real
# override to report on this site. The agent must inspect the live site to say which key is
# overridden and to what. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

MOD=web/modules/custom/cow_eval_override
mkdir -p "$MOD/src"

cat > "$MOD/cow_eval_override.info.yml" <<'YML'
name: 'COW eval override'
type: module
description: 'Eval fixture: overrides system.site slogan so Config Override Warn has something to report.'
core_version_requirement: ^10 || ^11
YML

cat > "$MOD/cow_eval_override.services.yml" <<'YML'
services:
  cow_eval_override.overrider:
    class: Drupal\cow_eval_override\CowEvalOverrides
    tags:
      - { name: config.factory.override, priority: 5 }
YML

cat > "$MOD/src/CowEvalOverrides.php" <<'PHP'
<?php

namespace Drupal\cow_eval_override;

use Drupal\Core\Cache\CacheableMetadata;
use Drupal\Core\Config\ConfigFactoryOverrideInterface;
use Drupal\Core\Config\StorageInterface;

/**
 * Eval fixture override provider.
 */
class CowEvalOverrides implements ConfigFactoryOverrideInterface {

  public function loadOverrides($names) {
    $overrides = [];
    if (in_array('system.site', $names, TRUE)) {
      $overrides['system.site'] = ['slogan' => 'Pinned by the deployment pipeline'];
    }
    return $overrides;
  }

  public function getCacheSuffix() {
    return 'cow_eval_override';
  }

  public function getCacheableMetadata($name) {
    return new CacheableMetadata();
  }

  public function createConfigObject($name, $collection = StorageInterface::DEFAULT_COLLECTION) {
    return NULL;
  }

}
PHP

drush en cow_eval_override -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
drush php:eval '
  print "hasOverrides=" . var_export(\Drupal::config("system.site")->hasOverrides(), TRUE) . "\n";
  print json_encode(\Drupal::service("config_override_warn.form_overrides")->getConfigOverrideDiffs("system.site")) . "\n";
' 2>/dev/null
echo "setup: cow_eval_override enabled, system.site:slogan overridden"
