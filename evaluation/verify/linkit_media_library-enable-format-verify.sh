#!/usr/bin/env bash
# Execution VERIFY: PASS when the text format lml_task_format has the Linkit URL converter filter
# ENABLED and its CKEditor 5 editor has the Linkit extension enabled and pointed at the
# lml_wire_profile profile - the two prerequisites linkit_media_library checks before it offers
# the Media Library button. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  $f = FilterFormat::load("lml_task_format");
  $e = Editor::load("lml_task_format");
  if (!$f || !$e) { print "FAIL format=" . var_export((bool) $f, TRUE) . " editor=" . var_export((bool) $e, TRUE) . "\n"; return; }
  $filters = $f->filters();
  $filterOn = $filters->has("linkit") && $filters->get("linkit")->status === TRUE;
  $lx = $e->getSettings()["plugins"]["linkit_extension"] ?? [];
  $profile = $lx["linkit_profile"] ?? NULL;
  $enabled = !empty($lx["linkit_enabled"]);
  $ok = $filterOn && $enabled && ($profile === "lml_wire_profile");
  print ($ok ? "PASS" : "FAIL") . " linkit_filter=" . var_export($filterOn, TRUE)
    . " linkit_enabled=" . var_export($enabled, TRUE)
    . " profile=" . var_export($profile, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
