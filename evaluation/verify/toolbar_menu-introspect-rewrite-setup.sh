#!/usr/bin/env bash
# Introspection SETUP: create a KNOWN toolbar_menu_element (id eval_tb_main) that targets the
# `main` menu with rewrite_label = TRUE — so an inspecting agent can read back the
# rewrite_label setting and the target menu. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  error_reporting(E_ERROR);
  $s = \Drupal::entityTypeManager()->getStorage("toolbar_menu_element");
  if ($e = $s->load("eval_tb_main")) { $e->delete(); }
  $s->create([
    "id" => "eval_tb_main",
    "label" => "My Custom Label",
    "menu" => "main",
    "weight" => 1,
    "rewrite_label" => TRUE,
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: toolbar_menu_element eval_tb_main created (menu=main, rewrite_label=TRUE)"
