#!/usr/bin/env bash
# Introspection SETUP: create a config snapshot (set=cs_eval, type=module, name=cs_evalmod)
# containing one config item, so an inspecting agent can read back the snapshot entity id.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = new Drupal\config_snapshot\ConfigSnapshotStorage("cs_eval", "module", "cs_evalmod");
  $s->write("cs_eval.settings", ["marker" => "present"]);
' >/dev/null 2>&1
echo "setup: config snapshot cs_eval.module.cs_evalmod created (config_snapshot.snapshot.cs_eval.module.cs_evalmod)"
