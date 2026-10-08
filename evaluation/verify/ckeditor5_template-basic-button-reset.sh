#!/usr/bin/env bash
# HARD (execution) reset: guarantee a clean, known baseline for the "add the Template button to
# basic_html" task. Ensures the basic_html text format uses the CKEditor 5 editor, then removes any
# ckeditor5_template "template" toolbar item + plugin config so the task starts from empty state
# (verify must FAIL here). No arguments.
set -uo pipefail
cd /var/www/html

drush php:eval '
  // Ensure basic_html exists and uses CKEditor 5 (standard install ships this).
  $editor = \Drupal\editor\Entity\Editor::load("basic_html");
  if (!$editor || $editor->getEditor() !== "ckeditor5") {
    print "reset-error: basic_html is not a CKEditor 5 format\n";
    return;
  }
  // Strip the template button + plugin config to clear prior runs.
  $s = $editor->getSettings();
  if (isset($s["toolbar"]["items"])) {
    $s["toolbar"]["items"] = array_values(array_filter($s["toolbar"]["items"], fn($i) => $i !== "template"));
  }
  unset($s["plugins"]["ckeditor5_template_template"]);
  $editor->setSettings($s);
  $editor->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: basic_html is CKEditor 5, template button + config cleared"
