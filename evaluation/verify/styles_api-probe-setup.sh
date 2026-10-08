#!/usr/bin/env bash
# Introspection SETUP: create+enable the fixed helper module styles_api_probe registering a
# @Style plugin (id sap_probe_style) so an agent can introspect the live styles_api manager.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
M=web/modules/custom/styles_api_probe
mkdir -p "$M/src/Plugin/Style"
cat > "$M/styles_api_probe.info.yml" <<'YML'
name: 'Styles API Probe (eval fixture)'
type: module
description: 'Eval fixture: registers a Style plugin for styles_api introspection cases.'
core_version_requirement: ^8.8 || ^9 || ^10 || ^11
dependencies:
  - styles_api:styles_api
YML
cat > "$M/src/Plugin/Style/SapProbeStyle.php" <<'PHP'
<?php

namespace Drupal\styles_api_probe\Plugin\Style;

use Drupal\styles_api\Plugin\Style\StyleBase;

/**
 * @Style(
 *   id = "sap_probe_style",
 *   type = "element",
 *   label = @Translation("SAP Probe Style"),
 *   category = @Translation("SAP Probe Category"),
 * )
 */
class SapProbeStyle extends StyleBase {}
PHP
drush en styles_api_probe -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: styles_api_probe enabled (style sap_probe_style)"
