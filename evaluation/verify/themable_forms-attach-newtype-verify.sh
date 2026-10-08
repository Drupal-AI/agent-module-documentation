#!/usr/bin/env bash
# themable_forms execution VERIFY: PASS when content type themf_task exists AND its built node
# form's title element carries #form_id = 'node_themf_task_form' (added by themable_forms_form_alter).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\node\Entity\Node;
  if (!NodeType::load("themf_task")) { print "FAIL no-type\n"; return; }
  $form = \Drupal::service("entity.form_builder")->getForm(Node::create(["type" => "themf_task", "title" => "x"]), "default");
  $fid = $form["title"]["#form_id"] ?? NULL;
  print (($fid === "node_themf_task_form") ? "PASS" : "FAIL") . " form_id=" . var_export($fid, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
