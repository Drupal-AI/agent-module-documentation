#!/usr/bin/env bash
# Execution VERIFY: PASS when a name_format entity name_hardfmt exists whose pattern outputs
# family, then a separator, then given (family precedes given). We render a sample name via the
# parser and require it to equal "Smith, John" (accepts patterns f, g / f+jg / etc). Prints
# PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\name\Entity\NameFormat;
  $e = NameFormat::load("name_hardfmt");
  if (!$e) { print "FAIL entity=missing\n"; return; }
  $pattern = $e->get("pattern");
  $c = ["title"=>"Mr.","given"=>"John","middle"=>"","family"=>"Smith","generational"=>"","credentials"=>""];
  $rendered = (string) \Drupal::service("name.format_parser")->parse($c, $pattern);
  $ok = ($rendered === "Smith, John");
  print ($ok ? "PASS" : "FAIL") . " pattern=" . var_export($pattern, TRUE) . " rendered=" . var_export($rendered, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
