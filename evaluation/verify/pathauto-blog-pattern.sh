#!/usr/bin/env bash
# Live-state verification for the "article -> blog/[node:title]" pathauto task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Two independent checks:
#   cfg  — a pathauto_pattern config entity of type node with pattern blog/[node:title] exists
#   fn   — a freshly-created Article node actually receives a /blog/... URL alias
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $cfg = FALSE;
  foreach (\Drupal::entityTypeManager()->getStorage("pathauto_pattern")->loadMultiple() as $p) {
    if ($p->status() && $p->getType() === "canonical_entities:node"
        && stripos($p->getPattern(), "blog/[node:title]") !== FALSE) { $cfg = TRUE; }
  }
  $title = "Eval Blog Post " . substr(md5(microtime()), 0, 6);
  $node = \Drupal\node\Entity\Node::create(["type" => "article", "title" => $title]);
  $node->save();  // pathauto entity hooks generate the alias on save if a pattern matches
  $alias = \Drupal::service("path_alias.manager")->getAliasByPath("/node/" . $node->id());
  $fn = str_starts_with($alias, "/blog/");
  $node->delete();
  print ($cfg && $fn ? "PASS" : "FAIL") . " cfg=" . ($cfg?1:0) . " fn=" . ($fn?1:0) . " alias=" . $alias . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
