#!/usr/bin/env bash
# HARD execution reset: remove the layout_builder_blocks.styles config so no block restriction
# exists. On this empty state the verify must FAIL; it PASSES only after the agent restricts the
# Style tab to the Site branding block.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("layout_builder_blocks.styles")->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: layout_builder_blocks.styles config cleared"
