#!/usr/bin/env bash
# Live-state verification for the "render an OpenAPI doc via the openapi_ui element" hard case.
# Proves the agent's renderer plugin actually flows through the openapi_ui render element:
#   1. find the openapi_ui plugin PROVIDED BY module openapi_ui_eval_render (scoped, so the
#      medium fixture is ignored),
#   2. build a render array `#type => openapi_ui` using that plugin id and an (empty) array
#      schema, render it in isolation, and
#   3. require the rendered HTML to be NON-EMPTY — i.e. the plugin's build() returned real
#      markup wired through $element['ui'], not the base class's empty [].
# PASS (exit 0) requires: module installed + a plugin from it + non-empty rendered output.
# Prints PASS/FAIL with detail. No arguments. Paths relative to the Drupal root.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $ok_mod = \Drupal::moduleHandler()->moduleExists("openapi_ui_eval_render");
  $id = ""; $rendered = FALSE; $len = 0;
  if ($ok_mod) {
    $m = \Drupal::service("plugin.manager.openapi_ui.ui");
    foreach ($m->getDefinitions() as $pid => $def) {
      if (($def["provider"] ?? "") === "openapi_ui_eval_render") { $id = $pid; break; }
    }
    if ($id !== "") {
      $build = [
        "#type" => "openapi_ui",
        "#openapi_ui_plugin" => $id,
        "#openapi_schema" => [],
      ];
      try {
        $html = (string) \Drupal::service("renderer")->renderInIsolation($build);
        $len = strlen(trim($html));
        $rendered = $len > 0;
      } catch (\Throwable $e) { $rendered = FALSE; }
    }
  }
  $pass = $ok_mod && $id !== "" && $rendered;
  print ($pass ? "PASS" : "FAIL") . " mod=" . ($ok_mod?1:0) . " id=" . $id . " textlen=" . $len . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
