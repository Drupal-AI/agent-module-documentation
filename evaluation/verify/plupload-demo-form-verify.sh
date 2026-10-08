#!/usr/bin/env bash
# Execution VERIFY: PASS when the agent's custom module plupload_demo_eval is enabled AND its
# form Drupal\plupload_demo_eval\Form\DemoForm builds a render element of #type 'plupload'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ok = FALSE; $why = "module-not-enabled";
  if (\Drupal::moduleHandler()->moduleExists("plupload_demo_eval")) {
    $why = "form-or-element-missing";
    $cls = "Drupal\\plupload_demo_eval\\Form\\DemoForm";
    if (class_exists($cls)) {
      try {
        $form = \Drupal::formBuilder()->getForm($cls);
        foreach ($form as $k => $e) {
          if (is_array($e) && (($e["#type"] ?? "") === "plupload")) { $ok = TRUE; $why = "found #type plupload in element ".$k; break; }
        }
      } catch (\Throwable $t) { $why = "getForm-threw: ".$t->getMessage(); }
    } else { $why = "form-class-missing"; }
  }
  print (($ok) ? "PASS " : "FAIL ") . $why . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
