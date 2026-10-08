#!/usr/bin/env bash
# Execution VERIFY: PASS when the inbound path processor turns /subpathauto-eval/edit into
# /node/<nid>/edit, i.e. subpathauto is actually configured and working. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Symfony\Component\HttpFoundation\Request;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title", "Subpathauto Eval Page")->execute();
  if (!$ids) { print "FAIL node-missing\n"; return; }
  $nid = (int) reset($ids);
  $request = Request::create("/subpathauto-eval/edit");
  $result = \Drupal::service("path_processor_manager")->processInbound("/subpathauto-eval/edit", $request);
  $ok = ($result === "/node/" . $nid . "/edit");
  print ($ok ? "PASS" : "FAIL") . " processed=" . $result . " expected=/node/" . $nid . "/edit"
    . " depth=" . var_export(\Drupal::config("subpathauto.settings")->get("depth"), TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
