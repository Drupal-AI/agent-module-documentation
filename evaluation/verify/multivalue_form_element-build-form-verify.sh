#!/usr/bin/env bash
# Execution VERIFY: the agent must have created+enabled a custom module `mfe_demo`
# exposing form id mfe_demo_form (class Drupal\mfe_demo\Form\MfeDemoForm) that uses the
# `multivalue` element for an unlimited-cardinality `contacts` field with name+mail children.
# PASS when the built form's `contacts` is #type=multivalue, has an add_more button, and
# delta 0 contains name+mail. exit 0 pass / 1 fail. Fails cleanly if the module is absent.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\Core\Form\FormState;
  $cls = "Drupal\\mfe_demo\\Form\\MfeDemoForm";
  if (!\Drupal::moduleHandler()->moduleExists("mfe_demo") || !class_exists($cls)) { print "FAIL missing mfe_demo\n"; return; }
  try {
    $fs = new FormState();
    $form = \Drupal::formBuilder()->buildForm($cls, $fs);
  } catch (\Throwable $e) { print "FAIL build error: ".$e->getMessage()."\n"; return; }
  $c = $form["contacts"] ?? NULL;
  $type = $c["#type"] ?? "none";
  $add  = isset($c["add_more"]) ? "yes" : "no";
  $kids = ($c && isset($c[0])) ? implode(",", array_values(array_filter(array_keys($c[0]), fn($k)=>$k!=="_weight" && ($k[0]??"") !== "#"))) : "";
  $ok = ($type === "multivalue" && $add === "yes" && str_contains($kids,"name") && str_contains($kids,"mail"));
  print ($ok?"PASS":"FAIL")." type=$type add_more=$add children=$kids\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
