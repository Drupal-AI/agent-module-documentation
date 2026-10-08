#!/usr/bin/env bash
# Execution VERIFY: the agent must have created+enabled a custom module `mfe_caps_demo`
# exposing form id mfe_caps_demo_form (class Drupal\mfe_caps_demo\Form\MfeCapsDemoForm) that
# uses the `multivalue` element for an `aliases` field with #cardinality = 2 (so NO add_more
# button), a single child `value` textfield, pre-populated with two default rows Alpha/Beta.
# PASS when the built form's `aliases` is #type=multivalue, has NO add_more button, and
# renders exactly two default rows whose child `value` #default_value are Alpha and Beta.
# exit 0 pass / 1 fail. Fails cleanly if the module is absent.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\Core\Form\FormState;
  $cls = "Drupal\\mfe_caps_demo\\Form\\MfeCapsDemoForm";
  if (!\Drupal::moduleHandler()->moduleExists("mfe_caps_demo") || !class_exists($cls)) { print "FAIL missing mfe_caps_demo\n"; return; }
  try {
    $fs = new FormState();
    $form = \Drupal::formBuilder()->buildForm($cls, $fs);
  } catch (\Throwable $e) { print "FAIL build error: ".$e->getMessage()."\n"; return; }
  $a = $form["aliases"] ?? NULL;
  $type = $a["#type"] ?? "none";
  $add  = isset($a["add_more"]) ? "yes" : "no";
  $rows = [];
  if (is_array($a)) { foreach ([0,1] as $i) { if (isset($a[$i]["value"]["#default_value"])) { $rows[$i] = $a[$i]["value"]["#default_value"]; } } }
  $vals = implode(",", $rows);
  $ok = ($type === "multivalue" && $add === "no" && ($rows[0] ?? "") === "Alpha" && ($rows[1] ?? "") === "Beta");
  print ($ok?"PASS":"FAIL")." type=$type add_more=$add defaults=[$vals]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
