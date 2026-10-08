#!/usr/bin/env bash
# Execution VERIFY: PASS when an enabled module implements hook_block_type_form_alter() such
# that invoking it for block type 'basic' sets $form['bfa_marker']['#value'] to 'ok', while
# another bundle ('other') is left untouched. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\Core\Form\FormState;
  $mh = \Drupal::moduleHandler();
  $implemented = $mh->hasImplementations("block_type_form_alter");
  $fs = new FormState();
  $target = []; $mh->invokeAll("block_type_form_alter", [&$target, &$fs, "basic"]);
  $other = []; $mh->invokeAll("block_type_form_alter", [&$other, &$fs, "other"]);
  $marked = (($target["bfa_marker"]["#value"] ?? NULL) === "ok");
  $untouched = !isset($other["bfa_marker"]);
  $ok = $implemented && $marked && $untouched;
  print ($ok ? "PASS" : "FAIL") . " implemented=" . ($implemented?"yes":"no")
    . " marker=" . var_export($target["bfa_marker"]["#value"] ?? NULL, TRUE)
    . " other_untouched=" . ($untouched?"yes":"no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
