#!/usr/bin/env bash
# Introspection SETUP: create a KNOWN toolbar_menu_element (id eval_tb_admin) that puts the
# `admin` menu into the toolbar with label "Admin Shortcuts" — so an inspecting agent can
# read back which menu it targets and its label. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  error_reporting(E_ERROR);
  $s = \Drupal::entityTypeManager()->getStorage("toolbar_menu_element");
  if ($e = $s->load("eval_tb_admin")) { $e->delete(); }
  $s->create([
    "id" => "eval_tb_admin",
    "label" => "Admin Shortcuts",
    "menu" => "admin",
    "weight" => 0,
    "rewrite_label" => FALSE,
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: toolbar_menu_element eval_tb_admin created (menu=admin, label='Admin Shortcuts')"
