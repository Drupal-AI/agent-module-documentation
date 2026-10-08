#!/usr/bin/env bash
# Introspection SETUP: install a small module (jqonce_probe) that declares an asset library
# depending on core/jquery.once, so the agent has a concrete, live artefact whose dependency
# must be resolved against the running site's library registry. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
DIR=/var/www/html/web/modules/custom/jqonce_probe
mkdir -p "$DIR/js"
cat > "$DIR/jqonce_probe.info.yml" <<'YML'
name: 'jQuery Once Probe'
type: module
description: 'Eval fixture: declares a library that depends on core/jquery.once.'
core_version_requirement: ^10 || ^11
package: Testing
YML
cat > "$DIR/jqonce_probe.libraries.yml" <<'YML'
probe:
  version: 1.x
  js:
    js/jqonce_probe.js: {}
  dependencies:
    - core/drupal
    - core/jquery.once
YML
cat > "$DIR/js/jqonce_probe.js" <<'JS'
(function ($, Drupal) {
  Drupal.behaviors.jqonceProbe = {
    attach(context) {
      $('body', context).once('jqonce-probe');
    },
  };
})(jQuery, Drupal);
JS
drush pm:install jqonce_probe -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: module jqonce_probe enabled, library jqonce_probe/probe depends on core/jquery.once"
