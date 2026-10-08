#!/usr/bin/env bash
# Execution RESET: populate the depcalc cache (non-empty) so a clear task has something to do.
# Verify (cache empty) therefore FAILS on this reset state until the agent clears it. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\depcalc\DependentEntityWrapper; use Drupal\depcalc\DependencyStack;
  \Drupal::service("cache.depcalc")->deleteAllPermanent();
  $e = \Drupal\image\Entity\ImageStyle::load("thumbnail");
  \Drupal::service("entity.dependency.calculator")->calculateDependencies(new DependentEntityWrapper($e), new DependencyStack());
' >/dev/null 2>&1
n=$(drush php:eval 'print \Drupal::database()->query("SELECT COUNT(*) FROM {cache_depcalc}")->fetchField();' 2>/dev/null)
echo "reset: depcalc cache populated (rows=$n)"
