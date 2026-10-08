#!/usr/bin/env bash
# Execution CLEANUP: remove any simple_search_form_block with get_parameter=keys_ssf. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  foreach (Block::loadMultiple() as $b) {
    if ($b->getPluginId() === "simple_search_form_block") {
      $s = $b->get("settings");
      if (($s["get_parameter"] ?? "") === "keys_ssf") { $b->delete(); }
    }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: removed simple_search_form_block(s) with get_parameter=keys_ssf"
