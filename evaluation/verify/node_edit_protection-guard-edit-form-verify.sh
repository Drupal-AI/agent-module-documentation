#!/usr/bin/env bash
# Execution VERIFY: PASS when a nep_netb node exists AND its EDIT form has the
# node_edit_protection library attached. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\NodeType;
  if (!NodeType::load("nep_netb")) { print "FAIL no content type nep_netb\n"; return; }
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("type", "nep_netb")->range(0, 1)->execute();
  if (!$ids) { print "FAIL no nep_netb node\n"; return; }
  $node = \Drupal::entityTypeManager()->getStorage("node")->load(reset($ids));
  $form = \Drupal::service("entity.form_builder")->getForm($node, "default");
  $libs = $form["#attached"]["library"] ?? [];
  $ok = in_array("node_edit_protection/node_edit_protection", $libs, TRUE);
  print ($ok ? "PASS" : "FAIL") . " libs=" . implode(",", $libs) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
