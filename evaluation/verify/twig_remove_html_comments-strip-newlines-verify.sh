#!/usr/bin/env bash
# Execution VERIFY: PASS when state twig_remove_html_comments_nl_output holds the input processed
# by the module: it must keep 'Line one' and 'Line two', and must contain NO comment markers and
# NO newline/carriage-return characters (the filter strips \r and \n). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::state()->get("twig_remove_html_comments_nl_output");
  if (!is_string($v) || $v === "") { print "FAIL empty output\n"; return; }
  $keep = (strpos($v, "Line one") !== FALSE) && (strpos($v, "Line two") !== FALSE);
  $noComment = (strpos($v, "<!--") === FALSE) && (strpos($v, "-->") === FALSE) && (strpos($v, "drop this") === FALSE);
  $noNl = (strpos($v, "\n") === FALSE) && (strpos($v, "\r") === FALSE);
  $ok = $keep && $noComment && $noNl;
  print ($ok ? "PASS" : "FAIL") . " keep=" . var_export($keep,true) . " no_comment=" . var_export($noComment,true) . " no_newline=" . var_export($noNl,true) . " output=" . var_export($v, true) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
