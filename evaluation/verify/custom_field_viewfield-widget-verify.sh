#!/usr/bin/env bash
# Execution VERIFY (custom_field_viewfield): PASS when the "listing" subfield of field_cf_vf on
# node.cf_vf_eval.default uses the viewfield_select widget
# (component.settings.fields.listing.type === viewfield_select). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.cf_vf_eval.default");
  $c = $fd ? $fd->getComponent("field_cf_vf") : NULL;
  $w = $c["settings"]["fields"]["listing"]["type"] ?? "none";
  $ok = ($w === "viewfield_select");
  print ($ok ? "PASS" : "FAIL") . " subfield_widget=" . $w . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
