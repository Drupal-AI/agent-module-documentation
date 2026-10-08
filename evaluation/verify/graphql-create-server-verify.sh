#!/usr/bin/env bash
# Live-state verification for the "create a graphql_server" execution task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Two independent checks:
#   cfg   — a graphql_server config entity 'eval_build' exists with schema=composable_example
#           and endpoint=/graphql/eval-build
#   route — the endpoint route graphql.query.eval_build resolves at path /graphql/eval-build
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $cfg = FALSE;
  $s = \Drupal\graphql\Entity\Server::load("eval_build");
  if ($s && $s->get("schema") === "composable_example" && $s->get("endpoint") === "/graphql/eval-build") {
    $cfg = TRUE;
  }
  $route = FALSE;
  try {
    $r = \Drupal::service("router.route_provider")->getRouteByName("graphql.query.eval_build");
    if ($r && $r->getPath() === "/graphql/eval-build") { $route = TRUE; }
  }
  catch (\Throwable $e) { $route = FALSE; }
  print ($cfg && $route ? "PASS" : "FAIL") . " cfg=" . ($cfg?1:0) . " route=" . ($route?1:0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
