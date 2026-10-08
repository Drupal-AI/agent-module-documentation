#!/usr/bin/env bash
# Introspection SETUP: place a Form block instance (plugin formblock_node) named
# "FB Known Form" in the olivero content region, configured for the blog_post content type
# with the submission guidelines turned on. The agent must read the live block config to
# report which content type it renders. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("formblock_fb_known")) { $b->delete(); }
  Block::create([
    "id" => "formblock_fb_known",
    "theme" => "olivero",
    "region" => "content",
    "plugin" => "formblock_node",
    "weight" => 10,
    "status" => TRUE,
    "settings" => [
      "id" => "formblock_node",
      "label" => "FB Known Form",
      "label_display" => "visible",
      "provider" => "formblock",
      "type" => "blog_post",
      "form_mode" => "default",
      "show_help" => TRUE,
    ],
    "visibility" => [],
  ])->save();
' >/dev/null 2>&1
echo "setup: block.block.formblock_fb_known = formblock_node, type=blog_post, show_help=TRUE"
