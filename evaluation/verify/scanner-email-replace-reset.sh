#!/usr/bin/env bash
# Reset for the scanner "replace email domain oldcorp.example -> newcorp.example" task
# (multiple occurrences in one Article body). Clears prior eval nodes, restores
# scanner.admin_settings to install defaults (enabling node:article:body), creates the node.
# Idempotent. Verify FAILS on this state (original domain present).
set -uo pipefail
cd /var/www/html
drush php:eval 'error_reporting(0);
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "Eval Scanner Email"]) as $n) { $n->delete(); }
  \Drupal::configFactory()->getEditable("scanner.admin_settings")
    ->set("scanner_mode", TRUE)->set("scanner_wholeword", TRUE)->set("scanner_regex", FALSE)
    ->set("scanner_published", FALSE)->set("scanner_pathauto", FALSE)->set("scanner_language", "all")
    ->set("word_boundaries", "auto")
    ->set("enabled_content_types", ["node:article" => "node:article"])
    ->set("fields_of_selected_content_type", ["node:article:body" => "node:article:body"])->save();
  $node = \Drupal\node\Entity\Node::create([
    "type" => "article",
    "title" => "Eval Scanner Email",
    "body" => ["value" => "Reach us at info@oldcorp.example or sales@oldcorp.example anytime.", "format" => "basic_html"],
  ]);
  $node->save();
  print "reset: created Eval Scanner Email id=" . $node->id() . "\n";
' 2>/dev/null | grep -aE '^reset:'
drush cr >/dev/null 2>&1
echo "reset: scanner settings restored + node:article:body enabled"
