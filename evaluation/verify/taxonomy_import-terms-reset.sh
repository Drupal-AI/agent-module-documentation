#!/usr/bin/env bash
# Execution RESET: ensure vocabulary ti_task exists and is EMPTY, so a "import Red/Green/Blue"
# task genuinely fails until performed. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  if (!Vocabulary::load("ti_task")) {
    Vocabulary::create(["vid" => "ti_task", "name" => "Taxonomy Import Task"])->save();
  }
  $storage = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $terms = $storage->loadByProperties(["vid" => "ti_task"]);
  if ($terms) { $storage->delete($terms); }
' >/dev/null 2>&1
echo "reset: vocabulary ti_task present and empty"
