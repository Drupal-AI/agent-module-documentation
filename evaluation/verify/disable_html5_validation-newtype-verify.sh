#!/usr/bin/env bash
# Execution VERIFY: PASS when content type dhv_task exists AND its default node form carries
# #attributes['novalidate'] = 'novalidate' (supplied by disable_html5_validation). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\node\Entity\Node;
  if (!NodeType::load("dhv_task")) { print "FAIL no-type\n"; return; }
  $node = Node::create(["type" => "dhv_task", "title" => "probe"]);
  $form = \Drupal::service("entity.form_builder")->getForm($node, "default");
  $nv = $form["#attributes"]["novalidate"] ?? NULL;
  print (($nv === "novalidate") ? "PASS" : "FAIL") . " novalidate=" . var_export($nv, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
