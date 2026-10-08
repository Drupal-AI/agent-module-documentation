#!/usr/bin/env bash
# Execution VERIFY: PASS when probe_compiler is registered AND, instantiated via the manager,
# its compile() returns a string containing PROBE_OK. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\compiler\RefineableCompilerContext;
  use Drupal\compiler\CompilerInputDirect;
  $m = \Drupal::service("plugin.manager.compiler");
  if (!$m->hasDefinition("probe_compiler")) { print "FAIL no-definition"; return; }
  $ctx = new RefineableCompilerContext("probe_compiler", [], [new CompilerInputDirect("x")]);
  $out = $m->createInstance("probe_compiler")->compile($ctx);
  print (is_string($out) && strpos($out, "PROBE_OK") !== FALSE) ? "PASS" : "FAIL";
  print " out=" . var_export($out, TRUE);
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
