#!/usr/bin/env bash
# themable_forms execution VERIFY: PASS when content type themf_report exists, its built node form
# carries #form_id = 'node_themf_report_form', AND themable_forms_theme_suggestions_form_element()
# yields form_element__form_id__node_themf_report_form for such an element.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\node\Entity\Node;
  if (!NodeType::load("themf_report")) { print "FAIL no-type\n"; return; }
  $form = \Drupal::service("entity.form_builder")->getForm(Node::create(["type" => "themf_report", "title" => "x"]), "default");
  $fid = $form["title"]["#form_id"] ?? NULL;
  $sugg = themable_forms_theme_suggestions_form_element(["element" => ["#type" => "textfield", "#form_id" => $fid]]);
  $ok = ($fid === "node_themf_report_form") && in_array("form_element__form_id__node_themf_report_form", $sugg, TRUE);
  print (($ok) ? "PASS" : "FAIL") . " form_id=" . var_export($fid, TRUE) . " sugg=" . json_encode($sugg) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
