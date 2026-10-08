#!/usr/bin/env bash
# Execution VERIFY: PASS when the iv_task text format has the insert_view filter enabled AND a
# [view:...] tag really expands through that format (check_markup renders the frontpage view).
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fmt = \Drupal::entityTypeManager()->getStorage("filter_format")->load("iv_task");
  if (!$fmt) { print "FAIL format iv_task missing\n"; return; }
  $conf = $fmt->filters("insert_view")->getConfiguration();
  $enabled = !empty($conf["status"]);
  $html = "";
  if ($enabled) {
    $build = ["#type" => "processed_text", "#text" => "[view:frontpage=page_1]", "#format" => "iv_task"];
    $html = (string) \Drupal::service("renderer")->renderInIsolation($build);
  }
  $rendered = str_contains($html, "view-id-frontpage") || str_contains($html, "view-frontpage");
  $ok = $enabled && $rendered;
  print ($ok ? "PASS" : "FAIL") . " status=" . var_export($enabled, TRUE) . " expanded=" . var_export($rendered, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
