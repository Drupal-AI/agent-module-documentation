#!/usr/bin/env bash
# Execution VERIFY: PASS when mlp_exec_policy exists with memory 512M and carries a path
# constraint whose paths include /admin. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
$e = \Drupal::entityTypeManager()->getStorage("memory_limit_policy")->load("mlp_exec_policy");
$mem = $e ? $e->getMemory() : "none";
$has_path = FALSE;
if ($e) {
  foreach ($e->getConstraints() as $c) {
    if (($c["id"] ?? "") === "path" && str_contains($c["paths"] ?? "", "/admin")) { $has_path = TRUE; }
  }
}
$ok = ($e && $mem === "512M" && $has_path);
print ($ok ? "PASS" : "FAIL") . " memory=" . $mem . " path=" . var_export($has_path, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
