#!/usr/bin/env bash
# Introspection SETUP: create + enable a small host module (preprocess_med_host) that registers
# one Preprocess plugin (id preprocess_med_host.block, hook 'block') via *.preprocessors.yml, so
# an inspecting agent can list the live preprocess plugin definitions and report the hook.
# The module directory is created BEFORE enabling. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
D=web/modules/custom/preprocess_med_host
mkdir -p "$D/src/Plugin/Preprocess"
cat > "$D/preprocess_med_host.info.yml" <<'YML'
name: 'Preprocess Med Host'
type: module
core_version_requirement: ^10 || ^11
dependencies:
  - preprocess:preprocess
YML
cat > "$D/preprocess_med_host.preprocessors.yml" <<'YML'
preprocess_med_host.block:
  class: \Drupal\preprocess_med_host\Plugin\Preprocess\MedHostBlock
  hook: block
YML
cat > "$D/src/Plugin/Preprocess/MedHostBlock.php" <<'PHP'
<?php
namespace Drupal\preprocess_med_host\Plugin\Preprocess;
use Drupal\preprocess\PreprocessPluginBase;
class MedHostBlock extends PreprocessPluginBase {
  public function preprocess(array $variables): array {
    return $variables;
  }
}
PHP
drush en preprocess_med_host -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: module preprocess_med_host enabled, registers preprocess plugin (hook=block)"
