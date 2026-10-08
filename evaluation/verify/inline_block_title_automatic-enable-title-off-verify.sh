#!/usr/bin/env bash
# Execution VERIFY: PASS when the inline-block AddBlockForm label_display is a 'value' element defaulting to FALSE.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\Core\Plugin\Context\EntityContext;
  $display = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.ibta_h2.default");
  if (!$display || !$display->isLayoutBuilderEnabled()) { print "FAIL Layout Builder not enabled on node.ibta_h2.default\n"; return; }
  $manager = \Drupal::service("plugin.manager.layout_builder.section_storage");
  $storage = $manager->load("defaults", ["display" => EntityContext::fromEntity($display)]);
  if (!$storage) { print "FAIL no section storage\n"; return; }
  $form = \Drupal::formBuilder()->getForm("Drupal\\layout_builder\\Form\\AddBlockForm", $storage, 0, "content", "inline_block:basic");
  $ldt = $form["settings"]["label_display"]["#type"] ?? "MISSING"; $ldv = $form["settings"]["label_display"]["#default_value"] ?? "MISSING"; $ok = ($ldt === "value" && $ldv === FALSE); $detail = "label_display#type=".$ldt." #default=".var_export($ldv, TRUE);
  print ($ok ? "PASS" : "FAIL") . " " . $detail . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
