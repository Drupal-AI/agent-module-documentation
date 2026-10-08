#!/usr/bin/env bash
# Execution VERIFY: PASS when an Article node titled "IV Embed Task" exists whose body uses the
# iv_embed text format, carries an insert_view tag for the frontpage view's page_1 display with
# a limit of 3, and whose rendered body really contains the embedded view.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $nodes = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "IV Embed Task"]);
  if (!$nodes) { print "FAIL node IV Embed Task not found\n"; return; }
  $node = reset($nodes);
  if (!$node->hasField("body") || $node->get("body")->isEmpty()) { print "FAIL node has no body value\n"; return; }
  $value = $node->body->value;
  $format = $node->body->format;
  $tag_ok = (bool) preg_match("#\[view:\s*frontpage\s*=\s*page_1\s*=+\s*(?:limit:)?3\s*\]#i", $value);
  $format_ok = ($format === "iv_embed");
  $html = "";
  if ($format_ok) {
    $build = ["#type" => "processed_text", "#text" => $value, "#format" => $format];
    $html = (string) \Drupal::service("renderer")->renderInIsolation($build);
  }
  $rendered = str_contains($html, "view-id-frontpage") || str_contains($html, "view-frontpage");
  $ok = $tag_ok && $format_ok && $rendered;
  print ($ok ? "PASS" : "FAIL") . " format=" . $format . " tag=" . var_export($tag_ok, TRUE) .
    " rendered=" . var_export($rendered, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
