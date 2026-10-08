#!/usr/bin/env bash
# Introspection SETUP for the openapi_ui "known renderer plugin" medium cases.
#
# openapi_ui is a framework: it ships NO renderer plugins of its own, so on a bare site
# `plugin.manager.openapi_ui.ui` has zero definitions. To give the model a KNOWN plugin to
# read back, this script plants a tiny fixture module that provides one openapi_ui plugin
# with fixed, distinctive values the introspection cases assert on:
#   - module:        openapi_ui_eval_fixture (web/modules/custom/openapi_ui_eval_fixture)
#   - plugin id:     eval_fixture
#   - plugin label:  "Eval Fixture Renderer"
# Idempotent: rewrites the module files and re-enables every run. Paths are relative to the
# Drupal root (/var/www/html). Deprecation notices from unrelated contrib print to stderr and
# are discarded; the readable result is echoed at the end.
set -uo pipefail
cd /var/www/html

MOD=web/modules/custom/openapi_ui_eval_fixture
mkdir -p "$MOD/src/Plugin/openapi_ui/OpenApiUi"

cat > "$MOD/openapi_ui_eval_fixture.info.yml" <<'YML'
name: 'OpenAPI UI Eval Fixture'
type: module
description: 'Fixture renderer plugin planted for openapi_ui introspection evals.'
core_version_requirement: ^10.1.3 || ^11
package: Testing
dependencies:
  - openapi_ui:openapi_ui
YML

cat > "$MOD/src/Plugin/openapi_ui/OpenApiUi/EvalFixture.php" <<'PHP'
<?php

namespace Drupal\openapi_ui_eval_fixture\Plugin\openapi_ui\OpenApiUi;

use Drupal\openapi_ui\Plugin\openapi_ui\OpenApiUi;

/**
 * A known fixture renderer used by openapi_ui introspection evals.
 *
 * @OpenApiUi(
 *   id = "eval_fixture",
 *   label = @Translation("Eval Fixture Renderer"),
 * )
 */
class EvalFixture extends OpenApiUi {

  /**
   * {@inheritdoc}
   */
  public function build(array $render_element) {
    return ['#markup' => 'eval fixture renderer output'];
  }

}
PHP

drush en openapi_ui_eval_fixture -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: openapi_ui plugin 'eval_fixture' (label 'Eval Fixture Renderer') registered via module openapi_ui_eval_fixture"
