#!/usr/bin/env bash
# Execution VERIFY: PASS when paragraphs_set ps_multi exists with exactly 2 paragraphs in order
# bp_callout then bp_simple (label 'Multi Set').
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\paragraphs_sets\Entity\ParagraphsSet;
  $s = ParagraphsSet::load("ps_multi");
  $p = $s ? array_values((array) $s->get("paragraphs")) : [];
  $b0 = $p[0]["bundle"] ?? NULL; $b1 = $p[1]["bundle"] ?? NULL;
  $ok = ($s && $s->label() === "Multi Set" && count($p) === 2 && $b0 === "bp_callout" && $b1 === "bp_simple");
  print ($ok ? "PASS" : "FAIL") . " count=" . count($p) . " b0=" . var_export($b0, TRUE) . " b1=" . var_export($b1, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
