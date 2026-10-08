#!/usr/bin/env bash
# Live-state verification for the "build the eval_survey webform" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# PASS only if the webform eval_survey exists AND has a REQUIRED select element whose
# options include the keys poor, good and excellent, AND has at least one checkbox element.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $wf = \Drupal::entityTypeManager()->getStorage("webform")->load("eval_survey");
  if (!$wf) { print "FAIL webform eval_survey does not exist\n"; return; }
  $elements = $wf->getElementsDecodedAndFlattened();
  $select = $checkbox = FALSE;
  foreach ($elements as $el) {
    $type = $el["#type"] ?? "";
    $req  = !empty($el["#required"]);
    if ($type === "select" && $req) {
      $opts = array_map("strval", array_keys($el["#options"] ?? []));
      if (in_array("poor", $opts, TRUE) && in_array("good", $opts, TRUE) && in_array("excellent", $opts, TRUE)) {
        $select = TRUE;
      }
    }
    if ($type === "checkbox") { $checkbox = TRUE; }
  }
  $ok = $select && $checkbox;
  print ($ok ? "PASS" : "FAIL")
    . " required_select_with_options=" . ($select?1:0)
    . " checkbox=" . ($checkbox?1:0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
