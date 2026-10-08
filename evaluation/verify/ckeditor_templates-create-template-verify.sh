#!/usr/bin/env bash
# Execution VERIFY for "create the ckeditor_templates_task CKEditor template".
# PASS when the ckeditor_templates config entity exists, is enabled, is offered on the
# full_html text format, its HTML code contains the required two-col markup, AND the
# ckeditor_template plugin manager exposes the derivative config_template:ckeditor_templates_task
# (which is what actually makes it appear in the Templates dialog).
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  \Drupal::service("plugin.manager.ckeditor_template")->clearCachedDefinitions();
  $t = \Drupal::entityTypeManager()->getStorage("ckeditor_templates")->load("ckeditor_templates_task");
  $exists = (bool) $t;
  $status = $exists ? (bool) $t->status() : FALSE;
  $formats = $exists ? (array) $t->get("formats") : [];
  $has_format = in_array("full_html", array_filter(array_values($formats)), TRUE);
  $code = $exists ? (string) ($t->get("code")["value"] ?? "") : "";
  $has_markup = strpos($code, "two-col") !== FALSE;
  $defs = array_keys(\Drupal::service("plugin.manager.ckeditor_template")->getDefinitions());
  $derived = in_array("config_template:ckeditor_templates_task", $defs, TRUE);
  $ok = $exists && $status && $has_format && $has_markup && $derived;
  print ($ok ? "PASS" : "FAIL")
    . " exists=" . var_export($exists, TRUE)
    . " enabled=" . var_export($status, TRUE)
    . " full_html=" . var_export($has_format, TRUE)
    . " markup=" . var_export($has_markup, TRUE)
    . " plugin_derivative=" . var_export($derived, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
