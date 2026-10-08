#!/usr/bin/env bash
# Execution VERIFY: PASS when plugin.manager.form_alter yields a FormAlter plugin for
# base_form_id node_form whose formAlter() sets $form['pfa_base_marker']['#value']='ok'.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\Core\Form\FormState;
  $pm = \Drupal::service("plugin.manager.form_alter");
  $fs = new FormState();
  $target = []; foreach ($pm->getInstance(["base_form_id" => "node_form"]) as $p) { $p->formAlter($target, $fs, "node_article_form"); }
  $marker = $target["pfa_base_marker"]["#value"] ?? NULL;
  $ok = ($marker === "ok");
  print ($ok ? "PASS" : "FAIL") . " marker=" . var_export($marker, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
