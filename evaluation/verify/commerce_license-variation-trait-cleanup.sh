#!/usr/bin/env bash
# Execution CLEANUP: remove the 'commerce_license' trait from the default variation type,
# restoring baseline (no license trait). Idempotent. Exit 0.
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
echo "cleanup: 'commerce_license' trait removed from default variation type"
