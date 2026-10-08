#!/usr/bin/env bash
# Execution RESET: ensure the 'commerce_license' entity trait is NOT enabled on the default
# product variation type, so verify FAILS until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $t = \Drupal::entityTypeManager()->getStorage("commerce_product_variation_type")->load("default");
  if ($t) {
    $traits = array_values(array_diff($t->getTraits(), ["commerce_license"]));
    $t->setTraits($traits);
    $t->save();
  }
' >/dev/null 2>&1
echo "reset: 'commerce_license' trait removed from default variation type"
