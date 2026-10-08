#!/usr/bin/env bash
# Introspection SETUP: populate the depcalc cache by calculating dependencies of image style
# 'thumbnail' so the bin is non-empty for the agent to inspect. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\depcalc\DependentEntityWrapper; use Drupal\depcalc\DependencyStack;
  \Drupal::service("cache.depcalc")->deleteAllPermanent();
  $e = \Drupal\image\Entity\ImageStyle::load("thumbnail");
  \Drupal::service("entity.dependency.calculator")->calculateDependencies(new DependentEntityWrapper($e), new DependencyStack());
' >/dev/null 2>&1
n=$(drush php:eval 'print \Drupal::database()->query("SELECT COUNT(*) FROM {cache_depcalc}")->fetchField();' 2>/dev/null)
echo "setup: depcalc cache populated (rows=$n)"
