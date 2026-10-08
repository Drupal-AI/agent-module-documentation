#!/usr/bin/env bash
# MEDIUM (introspection) cleanup: remove the ckeditor5_template "template" toolbar item and its
# plugin config from every CKEditor 5 text format, restoring the baseline the -setup.sh changed.
# No arguments.
set -uo pipefail
cd /var/www/html

drush php:eval '
  foreach (\Drupal\editor\Entity\Editor::loadMultiple() as $e) {
    $s = $e->getSettings();
    $changed = FALSE;
    if (isset($s["toolbar"]["items"]) && in_array("template", $s["toolbar"]["items"], TRUE)) {
      $s["toolbar"]["items"] = array_values(array_filter($s["toolbar"]["items"], fn($i) => $i !== "template"));
      $changed = TRUE;
    }
    if (isset($s["plugins"]["ckeditor5_template_template"])) {
      unset($s["plugins"]["ckeditor5_template_template"]);
      $changed = TRUE;
    }
    if ($changed) { $e->setSettings($s); $e->save(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: template toolbar item + plugin config removed from all CKEditor 5 formats"
