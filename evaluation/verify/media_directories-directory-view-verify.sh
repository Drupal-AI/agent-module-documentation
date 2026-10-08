#!/usr/bin/env bash
# Execution VERIFY for "build a directory-scoped media view".
# PASS when a view md_task_media exists on the live site with:
#   * base_table media_field_data (a Media view),
#   * a page display whose path is 'md-task-media/%',
#   * a contextual filter (argument) on the `directory` field using the plugin the
#     media_directories module registers: plugin_id 'media_directory'.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  use Drupal\views\Entity\View;

  $view = View::load("md_task_media");
  if (!$view) { print "FAIL view=missing\n"; return; }

  $base_ok = $view->get("base_table") === "media_field_data";

  $arg_ok = FALSE;
  $arg_report = [];
  $path_ok = FALSE;
  foreach ($view->get("display") as $id => $display) {
    $opts = $display["display_options"] ?? [];
    foreach ($opts["arguments"] ?? [] as $name => $arg) {
      $arg_report[$id . ":" . $name] = ($arg["plugin_id"] ?? "?") . "/" . ($arg["field"] ?? "?");
      if (($arg["plugin_id"] ?? "") === "media_directory" && ($arg["field"] ?? "") === "directory") {
        $arg_ok = TRUE;
      }
    }
    if (trim((string) ($opts["path"] ?? ""), "/") === "md-task-media/%") { $path_ok = TRUE; }
  }

  $ok = $base_ok && $arg_ok && $path_ok;
  print ($ok ? "PASS" : "FAIL")
    . " base_table=" . var_export($view->get("base_table"), TRUE)
    . " path=" . var_export($path_ok, TRUE)
    . " arguments=" . json_encode($arg_report) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
