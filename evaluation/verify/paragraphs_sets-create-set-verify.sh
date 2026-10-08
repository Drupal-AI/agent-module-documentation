#!/usr/bin/env bash
# Execution VERIFY: PASS when paragraphs_set ps_task exists with label 'Task Set' and its first
# paragraph bundle is bp_simple.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\paragraphs_sets\Entity\ParagraphsSet;
  $s = ParagraphsSet::load("ps_task");
  $p = $s ? (array) $s->get("paragraphs") : [];
  $b0 = $p[0]["bundle"] ?? NULL;
  $ok = ($s && $s->label() === "Task Set" && $b0 === "bp_simple");
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($s?"yes":"no") . " label=" . var_export($s?$s->label():NULL, TRUE) . " bundle0=" . var_export($b0, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
