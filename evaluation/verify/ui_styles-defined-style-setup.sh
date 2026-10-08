#!/usr/bin/env bash
# Introspection SETUP (ui_styles main): ship a fixture module that defines a UI Styles style
# plugin so an inspecting agent can read it back from plugin.manager.ui_styles. Idempotent.
set -uo pipefail
cd /var/www/html
DIR="web/modules/custom/ui_styles_eval_fixture"
mkdir -p "$DIR"
cat > "$DIR/ui_styles_eval_fixture.info.yml" <<'YML'
name: 'UI Styles Eval Fixture'
type: module
description: 'Test fixture defining a UI Styles style plugin.'
core_version_requirement: ^10.3 || ^11 || ^12
package: 'Testing'
dependencies:
  - ui_styles:ui_styles
YML
cat > "$DIR/ui_styles_eval_fixture.ui_styles.yml" <<'YML'
ui_styles_eval_shadow:
  label: 'Eval Shadow'
  description: 'Shadow utilities defined by the eval fixture.'
  category: 'Eval Effects'
  options:
    ui-styles-eval-shadow: 'Shadow'
    ui-styles-eval-border: 'Border'
YML
drush en ui_styles_eval_fixture -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: module ui_styles_eval_fixture enabled; style plugin ui_styles_eval_shadow (category 'Eval Effects', options ui-styles-eval-shadow/ui-styles-eval-border)"
