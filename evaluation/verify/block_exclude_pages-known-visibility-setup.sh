#!/usr/bin/env bash
# MEDIUM setup: place a block whose core "Pages" (request_path) visibility uses the
# block_exclude_pages `!` exclude syntax, so the agent must inspect live block config
# to answer which pages the block is excluded from. Idempotent (delete-then-create).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("block");
  if ($b = $storage->load("bep_eval_known")) { $b->delete(); }
  $storage->create([
    "id" => "bep_eval_known",
    "theme" => "olivero",
    "region" => "content",
    "plugin" => "system_powered_by_block",
    "settings" => ["id" => "system_powered_by_block", "label" => "BEP Eval Known", "label_display" => "0"],
    "visibility" => [
      "request_path" => [
        "id" => "request_path",
        "pages" => "/user/*\n!/user/jc\n!/user/jc/*",
        "negate" => FALSE,
        "context_mapping" => [],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block bep_eval_known placed (pages: /user/* excluding /user/jc and /user/jc/*)"
