#!/usr/bin/env bash
# Introspection SETUP: create a snapshot (set=cs_eval2, type=module, name=cs_eval2mod) that
# captures the config object 'cs_eval2.demo.settings', so an agent can read back which config
# name is stored inside the snapshot. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = new Drupal\config_snapshot\ConfigSnapshotStorage("cs_eval2", "module", "cs_eval2mod");
  $s->write("cs_eval2.demo.settings", ["greeting" => "hello", "count" => 3]);
' >/dev/null 2>&1
echo "setup: snapshot cs_eval2.module.cs_eval2mod captures config name cs_eval2.demo.settings"
