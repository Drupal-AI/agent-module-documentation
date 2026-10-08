#!/usr/bin/env bash
# Execution VERIFY for bp_statistics "build a nested Statistics band".
# PASS when an article titled "BP Statistics Task" exists and its field_bpstat_task holds a
# paragraph of bundle bp_statistics with:
#   - bp_header === "By The Numbers"
#   - bp_width  === "paragraph--width--wide"
#   - exactly 3 referenced children, ALL of bundle bp_stat
#   - the three bp_statistic_header values are Uptime / Customers / Regions (any order)
#   - the child headed "Uptime" has bp_statistic_item "99.9%"
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", "BP Statistics Task")->execute();
  if (!$ids) { print "FAIL node=missing\n"; return; }
  $node = Node::load(reset($ids));
  if (!$node->hasField("field_bpstat_task")) { print "FAIL field=missing\n"; return; }
  $band = NULL;
  foreach ($node->get("field_bpstat_task")->referencedEntities() as $p) {
    if ($p->bundle() === "bp_statistics") { $band = $p; break; }
  }
  if (!$band) { print "FAIL paragraph=none-of-bundle-bp_statistics\n"; return; }

  $header = (string) $band->get("bp_header")->value;
  $width = (string) $band->get("bp_width")->value;
  $kids = $band->get("bp_statistic")->referencedEntities();
  $bundles_ok = TRUE;
  $map = [];
  foreach ($kids as $k) {
    if ($k->bundle() !== "bp_stat") { $bundles_ok = FALSE; continue; }
    $map[(string) $k->get("bp_statistic_header")->value] = (string) $k->get("bp_statistic_item")->value;
  }
  $headers = array_keys($map);
  sort($headers);
  $want = ["Customers", "Regions", "Uptime"];
  $ok = $header === "By The Numbers"
    && $width === "paragraph--width--wide"
    && count($kids) === 3
    && $bundles_ok
    && $headers === $want
    && ($map["Uptime"] ?? "") === "99.9%";
  print ($ok ? "PASS" : "FAIL")
    . " header=" . var_export($header, TRUE)
    . " width=" . var_export($width, TRUE)
    . " children=" . count($kids)
    . " all_bp_stat=" . var_export($bundles_ok, TRUE)
    . " headers=[" . implode(",", $headers) . "]"
    . " uptime=" . var_export($map["Uptime"] ?? NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
