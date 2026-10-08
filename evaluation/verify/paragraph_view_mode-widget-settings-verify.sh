#!/usr/bin/env bash
# Execution VERIFY for "restrict the pvm_cfg Paragraph view mode widget to default + pvm_teaser,
# default it to pvm_teaser and turn form-mode binding off".
# PASS when the paragraph_view_mode component of core.entity_form_display.paragraph.pvm_cfg.default
# has settings: view_modes keys == {default, pvm_teaser}, default_view_mode == 'pvm_teaser',
# form_mode_bind === FALSE. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("paragraph.pvm_cfg.default");
  $c = $fd ? $fd->getComponent("paragraph_view_mode") : NULL;
  $s = $c["settings"] ?? [];
  $modes = \array_keys(\array_filter($s["view_modes"] ?? []));
  \sort($modes);
  $expected = ["default", "pvm_teaser"];
  $ok = ($modes === $expected)
        && (($s["default_view_mode"] ?? NULL) === "pvm_teaser")
        && (($s["form_mode_bind"] ?? NULL) === FALSE);
  print ($ok ? "PASS" : "FAIL")
        . " view_modes=" . \implode(",", $modes)
        . " default_view_mode=" . \var_export($s["default_view_mode"] ?? NULL, TRUE)
        . " form_mode_bind=" . \var_export($s["form_mode_bind"] ?? NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
