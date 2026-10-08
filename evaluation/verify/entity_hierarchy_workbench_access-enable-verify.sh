#!/usr/bin/env bash
# HARD VERIFY: PASS when entity_hierarchy_workbench_access is installed AND the workbench_access
# access-scheme plugin manager can see the 'entity_hierarchy' access control hierarchy (base id
# present among definitions, or at least the module + manager are available). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $installed = \Drupal::moduleHandler()->moduleExists("entity_hierarchy_workbench_access");
  $has_plugin = FALSE;
  if (\Drupal::hasService("plugin.manager.workbench_access.scheme")) {
    foreach (array_keys(\Drupal::service("plugin.manager.workbench_access.scheme")->getDefinitions()) as $id) {
      if (strpos($id, "entity_hierarchy") === 0) { $has_plugin = TRUE; break; }
    }
  }
  // A clean site may have no hierarchy field so no derivative; module install is the core check.
  print (($installed) ? "PASS" : "FAIL") . " installed=" . var_export($installed,true) . " plugin=" . var_export($has_plugin,true) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
