#!/usr/bin/env bash
# Introspection SETUP: make sure emulsify_twig is installed so its two twig.extension services
# are really registered in the live container, and print what the site now has.
# Idempotent, non-destructive. Exit 0.
set -uo pipefail
cd /var/www/html
drush en emulsify_twig -y >/dev/null 2>&1
drush php:eval '
  foreach (["emulsify_twig.twig.emulsify_twig_bem", "emulsify_twig.twig.emulsify_twig_add_attributes"] as $id) {
    print $id . " => " . (\Drupal::hasService($id) ? get_class(\Drupal::service($id)) : "MISSING") . "\n";
  }
' 2>/dev/null
echo "setup: emulsify_twig enabled"
exit 0
