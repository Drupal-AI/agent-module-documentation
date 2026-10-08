#!/usr/bin/env bash
# Execution VERIFY: PASS when block_content_template is installed AND its block-content.html.twig
# template file is present in the module directory. exit 0 pass / 1 fail.
# (Avoids theme.registry->get(), which currently throws on this site via an unrelated contrib module.)
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $enabled = \Drupal::moduleHandler()->moduleExists("block_content_template");
  $path = \Drupal::service("extension.list.module")->getPath("block_content_template");
  $tpl = $path . "/templates/block-content.html.twig";
  $has_tpl = file_exists(DRUPAL_ROOT . "/" . $tpl);
  $ok = ($enabled && $has_tpl);
  print ($ok ? "PASS" : "FAIL") . " enabled=" . ($enabled ? "yes" : "no") . " template=" . ($has_tpl ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
