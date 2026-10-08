#!/usr/bin/env bash
# Execution VERIFY: PASS when plugin.manager.form_alter yields a FormAlter plugin for form_id
# user_login_form whose formAlter() sets $form['pfa_marker']['#value']='ok', while a different
# form_id (user_register_form) is left untouched. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\Core\Form\FormState;
  $pm = \Drupal::service("plugin.manager.form_alter");
  $fs = new FormState();
  $target = []; foreach ($pm->getInstance(["form_id" => "user_login_form"]) as $p) { $p->formAlter($target, $fs, "user_login_form"); }
  $other = []; foreach ($pm->getInstance(["form_id" => "user_register_form"]) as $p) { $p->formAlter($other, $fs, "user_register_form"); }
  $marker = $target["pfa_marker"]["#value"] ?? NULL;
  $untouched = !isset($other["pfa_marker"]);
  $ok = ($marker === "ok") && $untouched;
  print ($ok ? "PASS" : "FAIL") . " marker=" . var_export($marker, TRUE) . " other_untouched=" . ($untouched?"yes":"no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
