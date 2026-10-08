#!/usr/bin/env bash
# Live-state verification for the "build an openapi_ui renderer plugin" hard case.
# PASS (exit 0) requires ALL of:
#   mod  — the module openapi_ui_eval_build is installed
#   reg  — plugin.manager.openapi_ui.ui has a definition PROVIDED BY that module
#   impl — that plugin's class implements OpenApiUiInterface (i.e. a real renderer)
# Scoped to provider openapi_ui_eval_build so it never confuses the medium fixture plugin.
# Prints PASS/FAIL with detail. No arguments. Paths relative to the Drupal root.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $ok_mod = \Drupal::moduleHandler()->moduleExists("openapi_ui_eval_build");
  $reg = FALSE; $impl = FALSE; $id = "";
  if ($ok_mod) {
    $m = \Drupal::service("plugin.manager.openapi_ui.ui");
    foreach ($m->getDefinitions() as $pid => $def) {
      if (($def["provider"] ?? "") === "openapi_ui_eval_build") {
        $reg = TRUE; $id = $pid;
        try {
          $inst = $m->createInstance($pid);
          $impl = $inst instanceof \Drupal\openapi_ui\Plugin\openapi_ui\OpenApiUiInterface;
        } catch (\Throwable $e) { $impl = FALSE; }
        break;
      }
    }
  }
  $pass = $ok_mod && $reg && $impl;
  print ($pass ? "PASS" : "FAIL") . " mod=" . ($ok_mod?1:0) . " reg=" . ($reg?1:0) . " impl=" . ($impl?1:0) . " id=" . $id . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
