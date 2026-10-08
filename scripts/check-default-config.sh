#!/usr/bin/env bash
# Audit: does every enabled contrib module's shipped default config actually exist?
#
# A module can end up listed in core.extension while its config/install/*.yml was never
# imported (interrupted installs, or an install that was retried and reported "Already
# installed" so the config step was skipped). The module then looks Enabled but behaves
# as if unconfigured — which silently corrupts any documentation or eval case written
# against it.
#
# Usage (inside the DDEV web container, cwd = /var/www/html):
#   scripts/check-default-config.sh              # audit every enabled contrib module
#   scripts/check-default-config.sh --fix        # also install the missing default config
#
# Prints:  <module>\tMISSING\t<config name>   for each shipped config object not present.
set -uo pipefail
cd /var/www/html

FIX=0
[ "${1:-}" = "--fix" ] && FIX=1
# also honour CDC_FIX=1 from the environment (how wave-prepare.sh calls this)
[ "${CDC_FIX:-}" = "1" ] && FIX=1
export CDC_FIX="$FIX"

drush php:eval '
  $fix = (bool) getenv("CDC_FIX");
  $handler = \Drupal::service("module_handler");
  $storage = \Drupal::service("config.storage");
  $installer = \Drupal::service("config.installer");
  $missing_by_module = [];

  foreach ($handler->getModuleList() as $name => $ext) {
    $path = DRUPAL_ROOT . "/" . $ext->getPath();
    // contrib/custom only — core modules are installed by the installer itself
    if (strpos($ext->getPath(), "core/") === 0) { continue; }
    $dir = $path . "/config/install";
    if (!is_dir($dir)) { continue; }
    foreach (glob($dir . "/*.yml") as $file) {
      $cname = basename($file, ".yml");
      // skip optional// and entity config that legitimately may be absent
      if (!$storage->exists($cname)) {
        $missing_by_module[$name][] = $cname;
      }
    }
  }

  if (!$missing_by_module) { print "ALL-DEFAULT-CONFIG-PRESENT\n"; return; }

  foreach ($missing_by_module as $name => $cnames) {
    foreach ($cnames as $c) { print $name . "\tMISSING\t" . $c . "\n"; }
  }
  print "modules-affected=" . count($missing_by_module) . "\n";

  if ($fix) {
    foreach (array_keys($missing_by_module) as $name) {
      try { $installer->installDefaultConfig("module", $name); print "FIXED\t" . $name . "\n"; }
      catch (\Throwable $e) { print "FIX-FAILED\t" . $name . "\t" . $e->getMessage() . "\n"; }
    }
  }
' 2>/dev/null

# Second class of half-install: the module is enabled and its config is present, but its
# entity type was never registered, so the backing tables do not exist and writes are
# silently discarded (this is what hid a broken media_directories and site_settings).
# Only *installs* are auto-applied; a pending field/entity UNINSTALL is left alone because
# applying it removes data.
CDC_FIX2="$FIX" drush php:eval '
  $fix = (bool) getenv("CDC_FIX2");
  $m = \Drupal::entityDefinitionUpdateManager();
  $changes = $m->getChangeSummary();
  if (!$changes) { print "NO-PENDING-ENTITY-UPDATES\n"; return; }
  foreach ($changes as $type => $list) {
    foreach ($list as $c) { print "entity-update\t" . $type . "\t" . strip_tags($c) . "\n"; }
  }
  if (!$fix) { return; }
  foreach (array_keys($changes) as $id) {
    $et = \Drupal::entityTypeManager()->getDefinition($id, FALSE);
    if (!$et) { print "ENTITY-SKIP\t" . $id . "\t(no current definition)\n"; continue; }
    // Only install entity types that were genuinely never registered. If a
    // last-installed definition already exists, the pending change is a field- or
    // schema-level edit (often an UNINSTALL, which would remove data) — report it and
    // leave it for a human.
    if ($m->getEntityType($id) !== NULL) {
      print "ENTITY-SKIP\t" . $id . "\t(already installed; pending change is field/schema level)\n";
      continue;
    }
    try { $m->installEntityType($et); print "ENTITY-INSTALLED\t" . $id . "\n"; }
    catch (\Throwable $e) { print "ENTITY-FAILED\t" . $id . "\t" . $e->getMessage() . "\n"; }
  }
' 2>/dev/null
